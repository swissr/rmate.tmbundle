RMate is a [TextMate](http://macromates.com/) bundle for [R](http://www.r-project.org/about.html). It is based on the [R/R Console/Rdaemon](http://svn.textmate.org/trunk/Bundles) bundles and is focused on:

- easy to use, clear interface/menu
- support for Windows ([E-Texteditor](http://www.e-texteditor.com/))
- editing code, R/Rd snippets and getting help/info
- connect to the standard R frontends (R.app and RGui)

----

Install via git:

	### Mac
	cd ~/Library/Application Support/TextMate/Bundles
	git clone git://github.com/swissr/rmate.tmbundle.git rmate.tmbundle
	osascript -e 'tell app "TextMate" to reload bundles'
	
	### PC/Cygwin
	cd "$APPDATA/e/Bundles"
	git clone git://github.com/swissr/rmate.tmbundle.git rmate.tmbundle
	#menu: 'Bundles->Edit Bundles->Reload Bundles'
	#note: R_HOME must be defined (check E-Texteditor chapter)

or manually:

	- download
	  - the [master](http://github.com/swissr/rmate.tmbundle/zipball/master) (i.e. most recent) version or
	  - choose the (latest) tagged version [here](http://github.com/swissr/rmate.tmbundle/downloads)
	- unzip and rename to 'rmate.tmbundle' (i.e. remove swissr- and -hash)
	- install
	  - (mac)  double click to import into TextMate
	  - (pc)   move to %APPDATA%/e/Bundles, reload bundles

----

Changes (important things only):

- v0.4.2: generated files will always be built from scratch now (there was a bug in < v0.4.2 on Mac which didn't surface because of a cached file).

----
