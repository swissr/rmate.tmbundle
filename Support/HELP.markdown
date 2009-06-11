Overview
========

RMate is a [TextMate](http://macromates.com/) bundle for [R](http://www.r-project.org/about.html). It is based on the [R/R Console/Rdaemon](http://svn.textmate.org/trunk/Bundles) bundles and is focused on:

- easy to use, clear interface/menu
- support for Windows ([E-Texteditor](http://www.e-texteditor.com/))
- editing code, R/Rd snippets and getting help/info
- connect to the standard R frontends (R.app and RGui)

The shortcut buttons in this help contains the **Mac** and the **Windows** shortcuts. The Mac version has a much better concept. Some shortcuts are not available on Windows ('no' or 'no?'). For 'Ctrl+Alt+Shift' commands, the control keys must be released promptly (details see E-Texteditor chapter).

FWIW, I am not too fond of the underlying code (complicated, duplications) and would prefer something simpler in _one_ language (Ruby) only. But it works well and...


RMate guide
===========

Commands
--------

(mostly ^⇧ / Alt+Shift, with exceptions for conventions/technical/other reason)

### TextMate <-> R connection

<button>⌘R / Ctrl+R</button> **Run Document**, i.e. source document in R, <button>^⇧L / Alt+Shift+L</button> **Send Line** to R, <button>^⇧M / Alt+Shift+M</button> **Send Selection** to R ('M' stands for **M**arkierung [ger.]), <button>^⇧⏎ / Alt+Shift+Return</button> **Send Line and Step** to the next line, <button>^⇧⌘M / Ctrl+Alt+Shift+M</button> **Source Selection** in R (release control keys promptly).

A temporary file ($TM_BUNDLE_SUPPORT/temp/source.it)) will be used for sourcing.

### Completion and such

<button>^˽ / Alt+Space</button> **Completion**, inline menu with entries based on all installed packages and local function declarations. Btw, <button>⎋ / Esc</button> is the common TM Completion based on the current file, <button>^, / no</button> **Show Arguments**: popup to choose *all* or a *specific* argument. <button>^⇧I / Alt+Shift+I</button> **Declaration Tooltip**: shows the function signature for the current word. On Macs the tooltip will be triggered after a '(' (to disable, remove key equivalent in the bundle editor).

These 'intellisense' functions rely on an index which must be invoked/updated manually (with 'Build Index'). TODO: Show Arguments doesn't work on windows (script and shortcut).

### R Help and info

<button>^H / Alt+H</button> **Show/Search help for word**, based on selection or word the caret is located in. If none or more than one entries have been found, a frame document will be displayed which allows further searching (by index/fulltext). Because links don't work in this window it may be favorab le to use <button>^⇧H / Alt+Shift+H</button> **Help for word in browser** to be able to navigate. <button>^⇧H / Alt+Shift+H</button> also triggers other help-related commands: **RSiteSearch for word**, **RSeek for word** (internet search page), **R-help list (gmane)**/**All R mailing lists (gmane)** (archive to search/browse old messages), **Package List (CRAN)** and the **Local R doc startpage. <button>^⇧⌘H / Ctrl+Alt+Shift+H</button> **Open an R manual**, either the pdf or - if not available - a html version. The path is  'R\_HOME/doc/manual'.

If R\_HOME is not defined '/Library/Frameworks/R.framework/Versions/Current/Resources' will be taken (for Windows see below). IIRC _no_ pdf manuals will be installed by default, but it's imho a good idea to download them (place next to html versions). TODO: On Windows, Show/Search help doesn't work if no word has been found.

### Various Commands

<button>^⇧B / Alt+Shift+B</button> **Back to forward slashes**, helps with paths copied from the explorer. <button>^⇧F / Alt+Shift+F</button> **Find function** in current file or in all project files, based on selection or word the caret is located in. <button>^⇧N / Alt+Shift+N</button> **Negate** toggles between TRUE/FALSE, <button>^⇧P / no</button> **Preview Rd doc**, TODO: not supported on Windows, <button>^⇧R / Alt+Shift+R</button> **Wrap in region**, the selected text will be wrapped in '#{{' and '#}}' which are foldable. <button>^⇧⌘B / Ctrl+Alt+Shift+B</button> **Build Index** creates the files $TM_BUNDLE_SUPPORT/generated/(help.index & help.pkgs) with content based on all *installed* packages. The completion functions rely on this index. It must be re-build after package changes. On Windows there is an UTF-8 warning message but it still works. <button>^? / Alt+Shift+?</button> **Help** which displays this file. On Windows a strange (Alt+Shift+Ü) shortcut is beeing displayed in the menu (TODO: why?).

Snippets
---------

### R-Snippets

br⇥ (browser), fun⇥ and funs⇥ (function),

if⇥, ife⇥, ifee⇥, ifs⇥. for⇥, fors⇥. repeat⇥. while⇥. switch⇥, switchs⇥.

asd⇥ (as.data.frame), asi⇥ (as.integer), asm⇥ (as.matrix), asn⇥ (as.numeric). isd⇥ (is.data.frame), isi⇥ (is.integer), ism⇥ (is.matrix), isn⇥ (is.numeric).

### Rd-Snippets

rd.doc⇥ (create full Rd document, first you can accept or delete (with one key!) sections and then starting from the top fill in the function names, aliases, titles and the description.

rd.b⇥ (bold), rd.c⇥ (code), rd.cl⇥ (code and link), rd.em⇥ (emphasis), rd.enc⇥ (encoding), rd.l⇥ (link), rd.u⇥ (url).

rd.n⇥ (name), rd.a⇥ (alias), rd.t⇥ (title), rd.des⇥ (description), rd.us⇥ (usage), rd.arg⇥ (arguments), rd.i⇥ (item), rd.d⇥ (details), rd.v⇥ (value), rd.sec⇥ (section), rd.s⇥ (see also), rd.r⇥ (references), rd.aut⇥ (author), rd.ex⇥ (examples), rd.dr⇥ (dontrun), rd.k⇥ (keyword), rd.con⇥ (concept).


Installation
============

Requirements
------------

The R installation must include the *LATEX help files* (needed to build the (help) index).

Install bundle
--------------

Possible locations for TextMate bundles:

  - Inside the TextMate application (default bundles, will be overwritten with new installs)
  - In /Library/Application Support/TextMate/Bundles (check out from repos here)
  - In ~/Library/Application Support/TextMate/Pristine (download bundle and double click)
  - In ~/Library/Application Support/TextMate/Bundles (custom bundles and local diff against default/repos/pristine
  - (I have a softlink at ~/Library.. and the RMate git bundle is somewhere else).

### Mac

To manually install, get the bundle [here](http://cloud.github.com/downloads/swissr/rmate.tmbundle/rmate.tmbundle.zip), unzip and double click the rmate.tmbundle file (it will be in the Pristine folder then). Now reload the bundles.

Or with code:
<pre>
### git (place into '/Library')
INSTDIR="/Library/Application Support/TextMate/Bundles"
cd "$INSTDIR"
sudo git clone git://github.com/swissr/rmate.tmbundle.git rmate.tmbundle
osascript -e 'tell app "TextMate" to reload bundles'
</pre>
<pre>
### just download (place into ~/Library)
INSTDIR="$HOME/Library/Application Support/TextMate/Bundles/rmate.tmbundle"
mkdir -p "$INSTDIR"
cd "$INSTDIR"
curl -o rmate.tmbundle.zip http://cloud.github.com/downloads/swissr/rmate.tmbundle/rmate.tmbundle.zip
unzip rmate.tmbundle
rmdir __MACOSX
rm rmate.tmbundle.zip
osascript -e 'tell app "TextMate" to reload bundles'
</pre>

### Windows

Put the file into '%APPData%\e\Bundles', e.g. 'C:\Dokumente und Einstellungen\chappi\Anwendungsdaten\e\Bundles\rmate.tmbundle'


General notes
-------------

- Text/Source/Bundle bundles should be enabled.
- The other R bundles (R, R Console and Rdaemon) **shouldn't be active** together with RMate. Use the filter in the bundle editor to disable/enable (reason: some shortcuts are equal and a 'chooser-popup' would be displayed, declaration tooltip after '(' won't work at all because of this).
- I like the [ProjectPlus](http://ciaranwal.sh/2008/08/05/textmate-plug-in-projectplus) plugin. Note: it is only loaded in new projects, if TM is already running.

Windows (E-Texteditor)
----------------------

- Commands with 'CTRL+ALT+SHIFT' keys will only have a RETURN keystroke in RGui, i.e. be executed, if the **control keys have been released**. There is a little pause in the osascript replacement code to give you more time. Otherwise you'll have to press RETURN in the RGui window manually.
- In order to find/display the R manuals, R_HOME needs to be defined as an environment variable, e.g. 'C:\Programme\R\R-2.9.0'. Note: restart e after changing this variable.
- The bash script files in Support/bin must have Linux line endings (lf). Otherwise there will be $'\r': command not found error messages. There is a .gitattribute file in the bin folder so this should work.
- I like E-Texteditor generally but some versions are **quite/really buggy**. This is especially true with bundle development and shortcuts. I used an older version (1.0.21e) and now the current (1.0.35) which works well (except for shortcut assignments).
- Once **e crashed** on every start and I deleted the files 'config.db'/'e.db' to recover


Working with TM
===============

Conventions
-----------

If you are new to TextMate you should understand the following (rough, generalized, TM-only) concepts:

- Shortcuts with <button>^⇧</button> and <button>^⇧⌘</button> are ***bundle specific*** 
- <button>⌥⌘</button> may indicate ***toggling options*** 
- <button>^⌥⌘</button> often is for ***opening windows***
- <button>⌘</button> is for ***primary actions*** or de-facto standards 
- <button>^⌘</button> for commands related to ***project (scope)*** 
- Adding a <button>⇧</button> modifier indicates a ***twist*** on the plain key equivalent.

This and a list of standard key bindings can be found in the [manual](http://manual.macromates.com/en/key_bindings#key_bindings). The TM blog has an [entry](http://blog.macromates.com/2007/textmates-many-key-shortcuts/) about shortcuts. And finally a link to the common [cocoa shortcuts](http://support.apple.com/kb/HT1343). (^ Ctrl, ⌥ Alt, ⇧ Shift, ⌘ Cmd; ⇥ Tab, ⎋ Esc, fn Function key).

Toggling options (mostly ⌥⌘)
----------------------------

<button>⌥⌘D / no?</button> **Soft Wrap**, <button>⌥⌘I / no?</button> **Hide Invisibles**, <button>⌥⌘R / Ctrl+Alt+R</button> **Filter through (command)** (it helps to know [regex](http://manual.macromates.com/en/regular_expressions)

Opening windows (mostly ^⌥⌘)
----------------------------

<button>^⌥⌘B / Ctrl+B</button> **Open Bundle Editor**, <button>^⌥⌘D / no</button> **Open Drawer**, <button>^⌥⌘P / Ctrl+Alt+P</button> **Open as Webpreview**. <button>⇧^O / no</button> **Open Terminal in current folder**, <button>⌥F2 / no?</button> **Context menu**

Project & other important
-------------------------

<button>⌘T / Ctrl+Shift+T</button> **Quickly open file**, <button>⇧⌘T / Ctrl+L</button> **Open symbols...**,  <button>^⇑F / no</button> **Find in project**. <button>^⌘T / Ctrl+Alt+T</button> **Select a bundle item** (you can switch to search for *key equivalents* on the magnifying glass!!), <button>^⎋ / no</button> **Bundle item menu**. <button>⌥⌘M / no</button> **Record Macro (start/stop)**, <button>⇧⌘M / no</button> **Play Macro**. <button>⇧⌘H / no</button> **TextMate help**.

Edit, Navigate, Fold
--------------------

<button>^⇧/ / Ctrl+Shift+/</button> **(Un)Comment**, <button>⌘F2 / Ctrl+F2</button> **Bookmark** (define/undefine), <button>F2 / F2</button> **Go to Bookmark** (with ⇧ backwards), <button>⌘F1 / F1</button> **Fold/Unfold**, <button>^⌥⌘⇑/⇓ / Ctrl+up/down</button> **Scroll up or down**, <button>^L / no</button> **Centers cursor in middle of screen**, <button>⌘L / Ctrl+G</button> **Go to line**, button>⌥</button> + MOUSE: **Column Selection**


Contact, Credits & Licence
==========================

Contact (maintainer):

- Hans-Peter Suter gchappi at gmail com NOT YET - TODO chappi at swissr org
- (NOT YET - TODO [redmine.swissr.org](https://redmine.swissr.org))

Credits:

- Charilaos Skiadas - R/Rapp/Rdaemon developer/maintainer (TODO: check)
- Hans-Jörg Bibiko - R/Rapp/Rdaemon developer/maintainer (TODO: check)
- Hans-Peter Suter - RMate

License: RMate has the normal TextMate bundle license, i.e.<pre>
   Permission to copy, use, modify, sell and distribute this
   software is granted. This software is provided "as is" without
   express or implied warranty, and with no claim as to its
   suitability for any purpose.
</pre>

