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

```
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

S is for when you are in visual mode (to avoid triggering s)

use capital W to add space around the word

Finally, let's try out visual mode. Press a capital V (for linewise visual mode) followed by `S<p class="important">`

Old text                  Command     New text ~
      Hello w*orld!         yssB            {Hello world!}

There is also *yS* and *ySS* which indent the surrounded text and place it
on a line of its own.

In visual mode, a simple "S" with an argument wraps the selection.  This is
referred to as the *vS* mapping, although ordinarily there will be
additional keystrokes between the v and S.  In linewise visual mode, the
surroundings are placed on separate lines and indented.  In blockwise visual
mode, each line is surrounded.

Eight punctuation marks, (, ), {, }, [, ], <, and >, represent themselves
and their counterparts.  If the opening mark is used, contained whitespace is
also trimmed.  The targets b, B, r, and a are aliases for ), }, ], and >
(the first two mirror Vim; the second two are completely arbitrary and
subject to change).
```

[https://github.com/tpope/vim-surround](https://github.com/tpope/vim-surround)

[https://github.com/tpope/vim-surround](https://github.com/tpope/vim-surround)

[vim-surround/surround.txt at master · tpope/vim-surround](https://github.com/tpope/vim-surround/blob/master/doc/surround.txt)

-LUA

```lua

-- Passing VimL: For multiple lines, wrap string in double brackets:

vim.cmd("set notimeout") --pass VimL like this
vim.cmd([[
set notimeout
set encoding=utf-8
]])

--home directory problems - I had issue using ~ as a reference to home directory for
-- some backup files etc. so instead I
 --set HOME variable that I used by writing HOME = os.getenv("HOME")
--string concatenation uses .. operator, so to refer to my backup dir I wrote
 --vim.opt.backupdir = HOME .. "/.vim/backup"

--ESCAPE KEYE: double backslash - if you want to pass a special character \t to Vim, you need to write it as "\\t" in Lua

--ALT key mapping method
function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

function nmap(shortcut, command)
  map('n', shortcut, command)
end

function imap(shortcut, command)
  map('i', shortcut, command)
end

```

---

-CHEATSHEETS

[A Great Vim Cheat Sheet.pdf](VIM%20&%20NVIM%203d144f0736174627a6c05c4f1eb33d14/A_Great_Vim_Cheat_Sheet.pdf)

[Vim Cheat Sheet.pdf](VIM%20&%20NVIM%203d144f0736174627a6c05c4f1eb33d14/Vim_Cheat_Sheet.pdf)

[Boost Your Coding Fu With VSCode and Vim - Cheatsheet \_ Barbarian Meets Coding.pdf](VIM%20&%20NVIM%203d144f0736174627a6c05c4f1eb33d14/Boost_Your_Coding_Fu_With_VSCode_and_Vim_-_Cheatsheet___Barbarian_Meets_Coding.pdf)

[Vim Cheat Sheet.pdf](VIM%20&%20NVIM%203d144f0736174627a6c05c4f1eb33d14/Vim_Cheat_Sheet%201.pdf)
