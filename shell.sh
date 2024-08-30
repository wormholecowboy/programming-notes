
hash  #  list all commands
!! # Repeat last command

ps -ef   list all processes
lsof   list open files and ports
#   -i:22   specify port 22


### Disk space

d -h   human readable
d -h --summarize   (max depth 0)
d -d 2   (max depth 2)

### Security

sudo spctl --master-enable
sudo spctl --master-disable
spctl --status


#DELETING
#delete something recursively: 
find . -name ".DS_Store" -type f -delete

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
grep "string" . // search all files in folder
grep -rni "string" . // search all files recursively, case insensitive
grep -v string   # invert selection

# FINDING

find <dir> -iname <file> This will be case insensitive
find . -name "file.txt"
find . -empty <!-- # find empty files -->
find . -iname "*usingwildcards*"
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
tar -czvf tarballFilename.tar.gz fileORdir
# see inside tarball
tar -tzvf file
# extract
tar -xzvf file.tar.gz

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

# faster hide dock:
defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock

# 𝗖𝗵𝗮𝗻𝗴𝗲 𝗦𝗰𝗿𝗲𝗲𝗻𝘀𝗵𝗼𝘁 𝗗𝗲𝗳𝗮𝘂𝗹𝘁 𝘁𝗼 𝗝𝗣𝗚 (replace with png to undo):
defaults write com.apple.screencapture type jpg

# Dock: Hidden apps are transluscent:
defaults write com.apple.Dock showhidden -bool TRUE && killall Dock


# XARGS
# trims white space; takes output of command and makes it arg for next command
# echos by default with no arg
ls | xargs man

# put stdin into a var
ls | xargs -I {} echo "/random/path/{}"  # {} is arbitrary


# JQ
# select a field or subfield
cat file | jq '.field.nested_field'








