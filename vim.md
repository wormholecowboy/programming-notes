# TODO

-FIND & REPLACE
:%s every line
:s current line
/g every instance on line

# is an alternate delimiter

:%s/findWord/replaceWord/g (remove % for single line)

# MACROS

create: `q<register><commands>q`
execute: `@<reg>`
check registers: `:reg`
check specifc reg: `:reg <key>`

# MARKS

Marks: m <key>
Jump to mark: “ <key>
Use m <capital keys> for global marks

# CUT, COPY, PASTE

vip - select whole paragraph
vib - select inside parenth
vab - select parenth
viB - select inside brackets
vaB - select brackets
ciB - change inside brackets

# BUFFERS

:ls // list of current buffers
:bdelete <file> OR <num> (can do multiple)
:sbuffer <nameORnum> // open buff in new split

:e edit
:b // open new buffer
Close all but current: Ctrl w o
Open new split: w v, w s
Equal splits: ctrl w =

-REGISTERS

yanks stay in memory, most recent from 0-9
recall - “0p
last inserted text - “.

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
### search and replace and save all buffers
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




