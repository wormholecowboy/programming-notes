
hash  #  list all commands
!! # Repeat last command

ps -ef   list all processes
lsof   list open files and ports
#   -i:22   specify port 22


# DISK SPACE
### Summarize usage for a file and folders recursively
du -sh .
du -h .  # see each files usage
du -sh .[!.]* *  # include hidden files



### SECURITY
sudo spctl --master-enable
sudo spctl --master-disable
sudo spctl --status


#DELETING
#delete something recursively: 
find . -name ".DS_Store" -type f -delete



# MISC
# reusing commands and arguments
! :0 # the name of command executed.
! :1 # the first parameter of the previous command
! :4 # the fourth parameter of the previous command
! :* # all of the parameters of the previous command
! ^ # the first parameter of the previous command (same as !:1)
! $ # the final parameter of the previous command
! :-3 # all parameters in range 0-3 (inclusive)
! :2-5 # all parameters in range 2-5 (inclusive)
! ! # the previous command line

# peaking into files

head file.txt # shows first 10 lines
tail file.txt # shows last 10 lines
head -n 5 file.txt # get only 5 lines

# writing to file

echo "whatever" > file.txt <!-- # will overwrite -->
echo "whatever" >> file.txt <!-- # will append -->



# CREATE many files
touch file-{001..100}.txt



# ADD TO PATH
for users, add to rc file
for system-wide, edit /etc/profile
export PATH="$PATH:/opt/example/bin"



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



# MACOS / APPLE

# faster hide dock:
defaults write com.apple.dock autohide-delay -float 0; defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock

# 𝗖𝗵𝗮𝗻𝗴𝗲 𝗦𝗰𝗿𝗲𝗲𝗻𝘀𝗵𝗼𝘁 𝗗𝗲𝗳𝗮𝘂𝗹𝘁 𝘁𝗼 𝗝𝗣𝗚 (replace with png to undo):
defaults write com.apple.screencapture type jpg

# Dock: Hidden apps are transluscent:
defaults write com.apple.Dock showhidden -bool TRUE && killall Dock

# delay the dock
defaults write com.apple.dock autohide-delay -float .4; killall Dock




# XARGS
# trims white space; takes output of command and makes it arg for next command
# echos by default with no arg
ls | xargs man

# put stdin into a var
ls | xargs -I {} echo "/random/path/{}"  # {} is arbitrary


# JQ
# select a field or subfield
cat file | jq '.field.nested_field'





