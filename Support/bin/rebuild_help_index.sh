# note: dialog removed because it didn't work (well) on windows

# variables
if [ "$OSTYPE" == "cygwin" ]; then R="$R_HOME/bin/Rterm.exe"; else R="R"; fi
GEN="$TM_BUNDLE_SUPPORT"/generated
PKGS="$GEN"/help.pkgs
INDEX="$GEN"/help.index
LIBPATHSFILE="$GEN"/libpaths

# generated folder must exist, delete existing generated files
mkdir -p "$GEN"
rm -f "$GEN/*"

# generate index files
echo "cat(.libPaths())" | $R --slave > "$LIBPATHSFILE"
LIBPATHS=$(cat "$LIBPATHSFILE")

for lpath in $LIBPATHS
do
  ls "$lpath" | grep -v -F . >> "$PKGS"
# '-f' not supported with cygwin    FILE=$(find -f "$lpath"/* -name AnIndex)
  FILE=$(find "$lpath"/* -name AnIndex)
  for f in $FILE
  do
    lib=$(echo -n "${f//\//\\/}" | sed 's/\\\/help\\\/AnIndex//')
    cat "$f" | perl -e "while(<>){\$a=\$_;\$a=~s!(.*?)\t(.*?)(\r?)(\n)!\$1\t$lib/latex/\$2.tex\$4!;print \$a;}" >> "$INDEX"
  done
done

echo "Help Index has been built"