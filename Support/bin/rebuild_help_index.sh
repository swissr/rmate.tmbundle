#dispose all frozen ProgressDialogs
# {
# while [ 1 ]
# do
#   res=$("$DIALOG" -x `"$DIALOG" -l 2>/dev/null| cut -d " " -f 1` 2>/dev/null)
#   [[ ${#res} -eq 0 ]] && break
# done
# } &
# 

#rebuild help.index?
# TODO: not sure if the else part is necessary/works for mac
if [ "$OSTYPE" == "cygwin" ]; then R="$R_HOME/bin/Rterm.exe"; else R="R"; fi
GEN="$TM_BUNDLE_SUPPORT"/generated
PKGS="$GEN"/help.pkgs
PKGSTEMP="$GEN"/help.pkgstemp
INDEX="$GEN"/help.index
LIBPATHSFILE="$GEN"/libpaths

# get LIB paths from R
if [ ! -e "$LIBPATHSFILE" ]; then
  echo "cat(.libPaths())" | $R --slave > "$LIBPATHSFILE"
fi
LIBPATHS=$(cat "$LIBPATHSFILE")

#check for removed/installed packages
if [ -e "$PKGS" ]; then
  rm -f "$PKGSTEMP"
  for lpath in $LIBPATHS
  do
    ls "$lpath" | grep -v -F . >> "$PKGSTEMP"
  done
  if ! cmp --silent "$PKGS" "$PKGSTEMP"; then
    [[ -e "$INDEX" ]] && rm "$INDEX"
    [[ -e "$PKGS" ]] && rm "$PKGS"
  fi
  rm "$PKGSTEMP"
else
  [[ -e "$INDEX" ]] && rm "$INDEX"
fi

if [ ! -e "$INDEX" ]; then
  # export token=$("$DIALOG" -a ProgressDialog -p "{title=Rdaemon;isIndeterminate=1;summary='R Documentation';details='Create Help Index…';}")
  rm -f "$PKGS"
  for lpath in $LIBPATHS
  do
    ls "$lpath" | grep -v -F . >> "$PKGS"
# '-f' not supported with cygwin    FILE=$(find -f "$lpath"/* -name AnIndex)
    FILE=$(find "$lpath"/* -name AnIndex)
    for f in $FILE
    do
      lib=$(echo -n "${f//\//\\/}" | sed 's/\\\/help\\\/AnIndex//')
      cat "$f" | perl -e "while(<>){\$a=\$_;\$a=~s!(.*?)\t(.*?)(\r)(\n)!\$1\t$lib/latex/\$2.tex\r\$4!;print \$a;}" >> "$INDEX"
    done
  done
  # "$DIALOG" -x $token 2&>/dev/null
fi

echo "Help Index has been built"