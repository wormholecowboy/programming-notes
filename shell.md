# Zsh | CLI

## cd

d
1,2,3,4
wc
uniq
cat
grep
which
mv, cp
history
head
tail
find
echo
cal
date
man
sort
!! Repeat last command
| column 

ls -R recursive ls

remove dir: rd
create and goto dir: mkcd something/somethingelse/somethingdeeper
word count: wc
unique lines: uniq (must be adjacent doubles)

history: then use !<line#>

> is an alternative to touch

### Security

sudo spctl --master-enable
sudo spctl --master-disable
spctl --status

### Navigation

- `Ctrl A` - Jump to the *start* of the line
- `Ctrl E` - Jump to the *end* of the line
- ^ this also accepts suggested text
- `Ctrl F` - Jump *forward* one character
- `Ctrl B` - Jump *backward* one character
- `Alt F` - Jump *forward* one word
- `Alt B` - Jump *backward* one word

Ctrl Z and fg for minimizing and returning

### Editing

- `Ctrl U` - Clear the entire line
- `Ctrl K` - Clear line *after* the cursor
- `Ctrl W` - Clear the word *before* the cursor
- `Ctrl R` - History

#DELETING
delete something recursively: find . -name ".DS_Store" -type f -delete

# peaking into files

head file.txt # shows first 10 lines
tail file.txt # shows last 10 lines
head -n 5 file.txt # get only 5 lines

# writing to file

echo "whatever" > file.txt <!-- # will overwrite -->
echo "whatever" >> file.txt <!-- # will append -->

# GREP

grep "string" file.txt
grep "string \*" file.txt <!-- # use RegEx to search all -->
grep "string" file.txt file2.txt file3.txt
grep "string" _ // search all files in folder
grep -rni "string" _ // search all files recursively, case insensitive
grep -r string . (same thing)

# FINDING

find <dir> -iname <file> This will be case insensitive
find . -name "file.txt"
find . -empty <!-- # find empty files -->
find . -iname "_usingwildcards_"
-type d searches only dir
-type f searches only files
find ~ \( -iname '*jpeg' -o -iname '*jpg' \) using the OR flag -o

# CREATE many files

touch file-{001..100}.txt

# ESCAPE CHAR

\

# SYMLINK

ln -s ~/PathToLinkTO pathNickname #run this in the dir where you want the symlink

# remove symlink

rm symlinkNickname

# see current symlinks

find . -type l -ls
find . -maxdepth 1 -type l -ls # current dir only

# TARBALL (ZIP)

tar czvf <tarballFilename.tar.gz> <fileORdir>

# see inside tarball

tar tzvf <file>

# extract

tar xzvf <file.tar.gz>

-c : Creates Archive
-x : Extract the archive
-f : creates archive with given filename
-t : displays or lists files in archived file
-u : archives and adds to an existing archive file

-v : Displays Verbose Information
-A : Concatenates the archive files
-z : zip, tells tar command that creates tar file using gzip
-j : filter archive tar file using tbzip
-W : Verify a archive file
-r : update or add file or directory in already existed .tar file

trigger fzf anywhere: \*\*<tab>

# CHECK SCRIPTS BEFORE YOU DOWNLOAD THEM

wget [https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh](https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)
sh [install.sh](http://install.sh/)

# CHANGE PROMPT

# this only works for zsh?

PROMPT='%4~ $' # Shows 4 levels of subfolders and a $
PROMPT='%B%4~ $ %b' # Bold

# to change color, wrap in %F{} $f tags

PROMPT='%B%F{blue}%4~ $ %f%b'. #color, takes 256 xterm color codes

# Must save to .zshrc !!!

# CHANGE TERMINAL

install oh my zsh
install powerline fonts: [https://fmacedoo.medium.com/oh-my-zsh-with-powerline-fonts-pretty-simple-as-you-deserve-fbe7f6d23723](https://fmacedoo.medium.com/oh-my-zsh-with-powerline-fonts-pretty-simple-as-you-deserve-fbe7f6d23723)
change terminal settings for color preset: dark solarize
change font: whatever powerline font

change theme in .zshrc to “agnoster”
change vscode settings:

```
"terminal.integrated.fontFamily": "Source Code Pro for Powerline",
"terminal.integrated.shell.osx": "/bin/zsh"
```

edit .zshrc with correct prompt

pull name and computer out of prompt: `prompt_context() {}` (at the end of the .zshrc)

further customization: [https://gist.github.com/DukeNgn/9312a65e1535b3b1bffd9fed2c892079](https://gist.github.com/DukeNgn/9312a65e1535b3b1bffd9fed2c892079)

-CHEATSHEETS

[bash commands.pdf](Zsh%20CLI%207d19e7179cbb4322ad2e96701b09f327/bash_commands.pdf)

[iterm 2.pdf](Zsh%20CLI%207d19e7179cbb4322ad2e96701b09f327/iterm_2.pdf)

# STOW

- real files site inside a package (named dir)
- package sits inside your stow dir (like .dotfiles, that’s a stow dir)
- from stow dir, run `stow packageName` to create a stow with whatever inside your package

# MACOS

faster hide dock:
defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock

𝗖𝗵𝗮𝗻𝗴𝗲 𝗦𝗰𝗿𝗲𝗲𝗻𝘀𝗵𝗼𝘁 𝗗𝗲𝗳𝗮𝘂𝗹𝘁 𝘁𝗼 𝗝𝗣𝗚 (replace with png to undo):
defaults write com.apple.screencapture type jpg

Dock: Hidden apps are transluscent:
defaults write com.apple.Dock showhidden -bool TRUE && killall Dock
