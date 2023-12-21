
# MISC
#!/bin/zsh
#1/usr/bin/python

vars are global by default, designate local with 'local' keyword preceding


## create var
MY_VAR = 'something'
echo "using $MY_VAR or ${MY_VAR}"

## assign output to var
VAR = $(someFunc)   //  older syntax uses `someFunc`

arguments are $1 $2 $3 etc.
list of arguments is $@

# There are some useful built-in variables, like:
echo "Last program's return value: $?"
echo "Script's PID: $$"
echo "Number of arguments passed to script: $#"
echo "All arguments passed to script: $@"
echo "Script's arguments separated into different variables: $1 $2..."

command && command   // 2nd command only runs if 1st does
command || command   // 2nd command runs if 1st fails, doesn't run if it succeeds
command ; command    // sep commands

$? gives you return code of prev command

exit 0  // give your script its own exit code

# compare strings with = and !=

# There are other comparison operators for numbers listed below:
## -ne - not equal
## -lt - less than
## -gt - greater than
## -le - less than or equal to
## -ge - greater than or equal to
## accept input

read -p "PROMPT" VARIABLE


best to use quotes around vars and strings in conditional statements 

# Conditions
if [condition]
then
    command
elif
    command
else
    command
fi

# To use && and || with if statements, you need multiple pairs of square brackets:
read age
if [[ "$name" == "Steve" ]] && [[ "$age" -eq 15 ]]

# to increment
((INDEX++))


# Case
case "$VAR" in
    val)
        command
        ;;
    val2)
        command
        ;;
esac


# Loops
## conditions can contain a command that returns an exit status
for VAR in $LIST
do
    command
done

use "sleep" to pause a script briefly

use "read" to read line by line
    while read -r line; do COMMAND; done < input.file
    The -r option passed to read command prevents backslash escapes from being interpreted.

you can also pipe into a while loop
    grep whatever | while read LINE
    
place sequencial words into their own vars per line
while read FIRST SECOND RESTOFLINE


# File conditions
[[ -e FILE ]]	Exists
[[ -r FILE ]]	Readable
[[ -h FILE ]]	Symlink
[[ -d FILE ]]	Directory
[[ -w FILE ]]	Writable
[[ -s FILE ]]	Size is > 0 bytes
[[ -f FILE ]]	File
[[ -x FILE ]]	Executable
[[ FILE1 -nt FILE2 ]]	1 is more recent than 2
[[ FILE1 -ot FILE2 ]]	2 is more recent than 1
[[ FILE1 -ef FILE2 ]]	Same files

[ -a existingfile ]	file 'existingfile' exists.	if [ -a tmp.tmp ]; thenrm -f tmp.tmp # Make sure we're not bothered by an old temporary filefi
[ -b blockspecialfile ]	file 'blockspecialfile' exists and is block special.	Block special files are special kernel files found in /dev, mainly used for ATA devices like hard disks, cd-roms and floppy disks.if [ -b /dev/fd0 ]; thendd if=floppy.img of=/dev/fd0 # Write an image to a floppyfi
[ -c characterspecialfile ]	file 'characterspecialfile' exists and is character special.	Character special files are special kernel files found in /dev, used for all kinds of purposes (audio hardware, tty's, but also /dev/null).if [ -c /dev/dsp ]; thencat raw.wav > /dev/dsp # This actually works for certain raw wav filesfi
[ -d directory ]	file 'directory' exists and is a directory.	In UNIX-style, directories are a special kind of file.if [ -d ~/.kde ]; thenecho "You seem to be a kde user."fi
[ -e existingfile ]	file 'existingfile' exists.	(same as -a, see that entry for an example)
[ -f regularfile ]	file 'regularfile' exists and is a regular file.	A regular file is neither a block or character special file nor a directory.if [ -f ~/.bashrc ]; thensource ~/.bashrcfi
[ -g sgidfile ]	file 'sgidfile' exists and is set-group-ID.	When the SGID-bit is set on a directory, all files created in that directory will inherit the group of the directory.if [ -g . ]; thenecho "Created files are inheriting the group '$(ls -ld . | awk '{ print $4 }')' from the working directory."fi
[ -G fileownedbyeffectivegroup ]	file 'fileownedbyeffectivegroup' exists and is owned by the effective group ID.	The effective group id is the primary group id of the executing user.if [ ! -G file ]; then # An exclamation mark inverts the outcome of the condition following itchgrp $(id -g) file # Change the group if it's not the effective onefi
[ -h symboliclink ]	file 'symboliclink' exists and is a symbolic link.	if [ -h $pathtofile ]; thenpathtofile=$(readlink -e $pathtofile) # Make sure $pathtofile contains the actual file and not a symlink to itfi
[ -k stickyfile ]	file 'stickyfile' exists and has its sticky bit set.	The sticky bit has got quite a history, but is now used to prevent world-writable directories from having their contents deletable by anyone.if [ ! -k /tmp ]; then # An exclamation mark inverts the outcome of the condition following itecho "Warning! Anyone can delete and/or rename your files in /tmp!"fi
[ -L symboliclink ]	file 'symboliclink' exists and is a symbolic link.	(same as -h, see that entry for an example)
[ -N modifiedsincelastread ]	file 'modifiedsincelastread' exists and was modified after the last read.	if [ -N /etc/crontab ]; thenkillall -HUP crond # SIGHUP makes crond reread all crontabsfi
[ -O fileownedbyeffectiveuser ]	file 'fileownedbyeffectiveuser' exists and is owned by the user executing the script.	if [ -O file ]; thenchmod 600 file # Makes the file private, which is a bad idea if you don't own itfi
[ -p namedpipe ]	file 'namedpipe' exists and is a named pipe.	A named pipe is a file in /dev/fd/ that can be read just once. See my bash tutorial for a case in which it's used.if [ -p $file ]; thencp $file tmp.tmp # Make sure we'll be able to readfile="tmp.tmp"    # the file as many times as we likefi
[ -r readablefile ]	file 'readablefile' exists and is readable to the script.	if [-r file ]; thencontent=$(cat file) # Set $content to the content of the filefi
[ -s nonemptyfile ]	file 'nonemptyfile' exists and has a size of more than 0 bytes.	if [ -s logfile ]; thengzip logfile    # Backup the old logfiletouch logfile # before creating a fresh one.fi
[ -S socket ]	file 'socket' exists and is a socket.	A socket file is used for inter-process communication, and features an interface similar to a network connection.if [ -S /var/lib/mysql/mysql.sock ]; thenmysql --socket=/var/lib/mysql/mysql.sock # See this MySQL tipfi
[ -t openterminal ]	file descriptor 'openterminal' exists and refers to an open terminal.	Virtually everything is done using files on Linux/UNIX, and the terminal is no exception.if [ -t /dev/pts/3 ]; thenecho -e "nHello there. Message from terminal $(tty) to you." > /dev/pts/3 # Anyone using that terminal will actually see this message!fi
[ -u suidfile ]	file 'suidfile' exists and is set-user-ID.	Setting the suid-bit on a file causes execution of that file to be done with the credentials of the owner of the file, not of the executing user.if [ -u executable ]; thenecho "Running program executable as user $(ls -l executable | awk '{ print $3 }')."fi
[ -w writeablefile ]	file 'writeablefile' exists and is writeable to the script.	if [ -w /dev/hda ]; thengrub-install /dev/hdafi
[ -x executablefile ]	file 'executablefile' exists and is executable for the script.	Note that the execute permission on a directory means that it's searchable (you can see which files it contains).if [ -x /root ]; thenecho "You can view the contents of the /root directory."fi



# WILDCARDS
* matches zero or more
? matches exactly one char
[] matches one char inside, like regex
[!] negative matches
[a-f] ranges
[[:alpha:]] [[:digit:]] char classes, upper, lower, alnum, space, etc.

for FILE in /var/www/*.html


# LOGGING
syslog is a Linux standard that integrates with any app
Facilities: what type of log to use, if unsure, use "user" or "local"0-7
Severities: level of error
These can both send the logs to different files on your sys
var/log/*

logger "message"
logger -p facilty.severity "message"
logger -t myscript   // adds a tag for easy searching in log file
logger -s           // sends message to screen
logger -            // adds PID


# DEBUGGING
## print tracing or x-tracing - add x to shebang line
#!/bin/bash -x
set -x      to do it from the command line
set +x      to kill
these can be added inline to your script as well

adding "-e" will make your script exit if any command has a non-zero exit code

"-v" is same as x but does not expand vars and commands, shows them as is

### all can be combined

## Consider creating your own debug state
DEBUG=false
DEBUG="echo"

## PS4 - var that controls the debug command prompt
PS4='+ $BASH_SOURCE : $LINENO : '

## print non-printable chars
cat -v script.sh


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


