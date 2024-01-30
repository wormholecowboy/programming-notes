# Zsh | CLI

## cd

uniq
cal
date
hash    list all commands
!! Repeat last command
| column 

ps -ef   list all processes
lsof   list open files and ports
   -i:22   specify port 22

remove dir: rd
create and goto dir: mkcd something/somethingelse/somethingdeeper
word count: wc
unique lines: uniq (must be adjacent doubles)

history: then use !<line#>

> is an alternative to touch


### Disk space

d -h   human readable
d -h --summarize   (max depth 0)
d -d 2   (max depth 2)

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

# reusing commands and arguments
!:0 = the name of command executed.
!:1 = the first parameter of the previous command
!:4 = the fourth parameter of the previous command
!:* = all of the parameters of the previous command
!^ = the first parameter of the previous command (same as !:1)
!$ = the final parameter of the previous command
!:-3 = all parameters in range 0-3 (inclusive)
!:2-5 = all parameters in range 2-5 (inclusive)
!! = the previous command line

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

# ADD TO PATH

for users, add to rc file
for system-wide, edit /etc/profile
export PATH="$PATH:/opt/example/bin"

# SYMLINK

ln -s ~/PathToLinkTO pathNickname #run this in the dir where you want the symlink

# remove symlink

rm symlinkNickname

# see current symlinks

find . -type l -ls
find . -maxdepth 1 -type l -ls # current dir only

# ZIP
zip zippedfile.zip thing-to-zip.txt         // can also add files this way
zip -r archive.zip .  // recurse in cwd
zip -d archive.zip file-to-delete.txt
zip -u archive.zip file.txt     // update or add files
-m delete the original files

# TARBALL 

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
-z : tells tar to use gzip
    For .tar.xz archives use J instead of z, and for .tar.bz2 use j.
    -j : use tbzip  *.tar.bz2
    -J : use for *.tar.xz
-W : Verify a archive file
-r : update or add file or directory in already existed .tar file
-C : change install dir

example
tar -C /opt -xzf example.tar.gz 
unzip file.zip -d destination_folder

# CHECK SCRIPTS BEFORE YOU DOWNLOAD THEM

wget [https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh](https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)
sh [install.sh](http://install.sh/)

# CHANGE PROMPT

# this only works for zsh?
PROMPT='%4~ $' # Shows 4 levels of subfolders and a $
PROMPT='%B%4~ $ %b' # Bold

# to change color, wrap in %F{} $f tags
PROMPT='%B%F{blue}%4~ $ %f%b'. #color, takes 256 xterm color codes

# pull name and computer out of prompt: 
`prompt_context() {}` (at the end of the .zshrc)


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


# SED

sed 's/searchText/replaceText/flags' file.txt

## flags
i   case insensitive
g   all line occurences
1-9 pick the exact occurence
w   creates a file of only changed items

## edit in place and create backup
sed -i.bak 'patterns' file.txt

## can use any delimiter
sed 's#serach#replace#gi' file.txt

## delete a specific line
sed '/searchPatter/d' file.txt

## combine multi commands with ;
sed '/search/d ; otherSearch/d' file.txt
OR
sed -e 'command1' -e 'command2' file.txt

## replace only specific line
sed '3 s/search/replace' file.txt

## range
sed '1,32 s/search/replace' file.txt

## replace lines containing certain pattern
### also works with range
sed '/containingPatter/ s/search/replace' file.txt
