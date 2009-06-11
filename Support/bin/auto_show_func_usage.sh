TEXT=$(cat)

export WORD=$(ruby -- <<-SCR1
print ENV['TM_CURRENT_LINE'][0...ENV['TM_LINE_INDEX'].to_i].gsub!(/ *$/, "").match(/[\w.]*$/).to_s
SCR1
)

#check whether WORD is defined otherwise quit
[[ -z "$WORD" ]] && exit 200

[[ ! -f "$TM_BUNDLE_SUPPORT"/generated/help.index ]] && exit_show_tool_tip "help index missing, click 'Build Help Index' to generate it"

#get the reference for WORD
FILE=$(grep "^${WORD//./\\.}	" "$TM_BUNDLE_SUPPORT"/generated/help.index | awk '{print $2;}')
#get the library in which WORD is defined
LIB=$(echo -en \"$FILE\" | perl -pe 's!.*/library/(.*?)/latex.*!$1!')

#check whether something is found within the installed packages or within the curretn doc otherwise quit
if [ -z "$FILE" ]; then #look for local defined functions
	OUT=$(echo -en "$TEXT" | egrep -A 10 "${WORD//./\\.} *<\- *function *\(" | perl -e '
		undef($/);$a=<>;$a=~s/.*?<\- *function *(\(.*?\)) *[\t\n\{\w].*/$1/s;
		$a=~s/\t//sg;$a=~s/\n/ /g;print "$a" if($a=~m/^\(/ && $a=~m/\)$/s)
	' | fmt | perl -e 'undef($/);$a=<>;$a=~s/\n/\n\t/g;$a=~s/\n\t$//;print $a')

	LIB="local"
	[[ -z "$OUT" ]] && exit 200

	OUT=$WORD$OUT
else #get the usage from the latex file
	OUT=$(cat "$FILE" | perl -e '
		undef($/);$w=$ENV{"WORD"};$a=<>;
		$a=~m/\\begin\{Usage\}\n\\begin\{verbatim\}\n?.*?($w *\(.*?\))\n.*?\\end\{verbatim\}/s;
		if(length($1)) {
			print $1;
		} else {
			$a=~m/\\begin\{Usage\}\n\\begin\{verbatim\}\n?.*?($w *\(.*?\)).*?\\end\{verbatim\}/s;
			print "$1";
		}
')
fi

#if no usage is found show the HTML page for WORD otherwise output the command usage
if [ -z "$OUT" ]; then
	exit 200
else
	echo -n "$OUT"
fi

#output the library in which WORD is defined
echo -en "\n•• library: $LIB ••"
echo -e "\n$RDTEXT"