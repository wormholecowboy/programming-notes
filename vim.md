# TODO


# GLOBAL COMMAND
g/pattern           // print all lines containing pattern
g/pattern/command
g/thing/d           // delete
g/thing/d _         // delete to blackhole
g/thing1\|thing2/d   

g!/pattern/command  // inverse
v/pattern/command

g/[0-9]/d       // delete range
g/0\{3,6\}/d   // delete any line with 3-6 zeros

1,5g/pat/com    // lines
3,g/pat/com     // end at curr line
3,$/pat/com     // end of filej

. means the current line. A range of .,3 means between the current line and line 3.
$ means the last line in the file. 3,$ range means between line 3 and the last line.
+n means n lines after the current line. You can use it with . or without. 3,+1 or 3,.+1 means between line 3 and the line after the current line.

g/pat/Normal A  // exectute A from normal mode
g/const/normal @a  // execute macro

g/pat1/g/pat2/d  // delete recursively

g/pattern/t $   // copy all to end of file
g/pattern/m $   // move


-FIND & REPLACE
:%s every line
:s current line
/g every instance on line

# is an alternate delimiter

:%s/findWord/replaceWord/g (remove % for single line)

# LAZY NVIM
Lazy sync // install, clean, update
Lazy help
Lazy home

Lazy restore [plugin]
Lazy clean  // get rid of old plugins
Lazy update [plugin]

Lazy log [plugin]
    press r to revert to a commit
Lazy restore  // revert to lock file (check git for previous versions if needed)
    or keep a backup file of lock file before updating all plugins

# MACROS

create: `q<register><commands>q`
execute: `@<reg>`
check registers: `:reg`
check specifc reg: `:reg <key>`

# MARKS

Marks: m <key>
Jump to mark: “ <key>
Use m <capital keys> for global marks

:e edit
:b // open new buffer
:sbuffer <nameORnum> // open buff in new split
:sb
Close all but current: Ctrl w o
Open new split: w v, w s
Equal splits: ctrl w =

-REGISTERS

yanks stay in memory, most recent from 0-9
recall - “0p
last inserted text - “.

-INSERT MODE

Ctrl-o       execute normal mode command

10i          repeating insert
Ctrl-w      " delete one word
Ctrl-u      " delete entire line
Ctrl-r      insert from register
Ctrl-r "    insert the last yank/delete
Ctrl-r %    insert file name
Ctrl-r /    insert last search term
Ctrl-r :    insert last command line

Ctrl-x Ctrl-y   " scroll up
Ctrl-x Ctrl-e   " scroll down


Ctrl-x Ctrl-l   " insert a whole line
Ctrl-x Ctrl-n   " insert a text from current file
Ctrl-x Ctrl-i   " insert a text from included files
Ctrl-x Ctrl-f   " insert a file name
Ctrl-x Ctrl-]   " insert from tags (must have tags)
Ctrl-x Ctrl-o   " insert from omnicompletion. Filetype specific.


-SURROUND


( = b
{ = B
[ = r
< = a

**changing**
csttstrong - change tag to <strong>
cs’” - change from ‘ to “

**deleting**
dst - delete surrounding tag
ds” - delete surrounding “
cs’! - change surround from a single quote to a bang

**adding**
ysiw - basic adding phrase (sans thing to add)
ysiw] - add square brackets (without space)
ySa[{ - add curlies around square
yss - surround whole line, ignoring leading whitespace
ysib( - surround body with parenth
ysiw<tag> - surround word with <tag>

**visual mode**
S is for when you are in visual mode (to avoid triggering s)
use capital W to add space around the word
yS"  -  surround highlighted with "

In visual mode, a simple "S" with an argument wraps the selection.  This is
referred to as the *vS* mapping, although ordinarily there will be
additional keystrokes between the v and S.  In linewise visual mode, the
surroundings are placed on separate lines and indented.  In blockwise visual
mode, each line is surrounded.

There is also *yS* and *ySS* which indent the surrounded text and place it
on a line of its own.

Eight punctuation marks, (, ), {, }, [, ], <, and >, represent themselves
and their counterparts.  If the opening mark is used, contained whitespace is
also trimmed.  The targets b, B, r, and a are aliases for ), }, ], and >
(the first two mirror Vim; the second two are completely arbitrary and
subject to change).


# QUICK FIX LIST
copen
ccl  clear

### nav
cc <number>
cfirst
clast
cnext
cprev

### navigate quick fix lists (last 10)
colder
cnewer

### seach folder recursively
vim /pattern/ src/**

### cfdo applies changes to all files in qf list, cdo applies to all entries (lines)
### search and replace and save all buffers (global variable rename)
cdo %s/pattern/replace/g | update

### close all files
cfdo bd

### save quick fix list
w file.txt



# LUA

-- Passing VimL: For multiple lines, wrap string in double brackets:

vim.cmd("set notimeout") --pass VimL like this
vim.cmd([[
set notimeout
set encoding=utf-8
]])

## HOME DIR
--home directory problems - I had issue using ~ as a reference to home directory for
-- some backup files etc. so instead I
 --set HOME variable that I used by writing HOME = os.getenv("HOME")
--string concatenation uses .. operator, so to refer to my backup dir I wrote
 --vim.opt.backupdir = HOME .. "/.vim/backup"

--ESCAPE KEY: double backslash - if you want to pass a special character \t to Vim, you need to write it as "\\t" in Lua




