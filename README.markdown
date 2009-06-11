RMate is a [TextMate](http://macromates.com/) bundle for [R](http://www.r-project.org/about.html). It is based on the [R/R Console/Rdaemon](http://svn.textmate.org/trunk/Bundles) bundles and is focused on:

- easy to use, clear interface/menu
- support for Windows ([E-Texteditor](http://www.e-texteditor.com/))
- editing code, R/Rd snippets and getting help/info
- connect to the standard R frontends (R.app and RGui)

----

Install via git:<pre>
INSTDIR=~/"Library/Application Support/TextMate/Bundles"
cd "$INSTDIR"
git clone git://github.com/swissr/rmate.tmbundle.git rmate.tmbundle
osascript -e 'tell app "TextMate" to reload bundles'
</pre>

or by hand:<pre>
- download
  - the [master](http://github.com/swissr/rmate.tmbundle/zipball/master) (i.e. most recent) version or
  - choose the (latest) tagged version [here](http://github.com/swissr/rmate.tmbundle/downloads)
- unzip and rename to 'rmate.tmbundle' (i.e. remove swissr- and -hash)
- double click to import into TextMate and choose 'Reload the bundles'.
</pre>

----
