#!/bin/zsh
#!/usr/bin/python
set -euo pipefail
# -e exit on any error
# -u exit on unset var
# -o pipefail exit on pipefail
# good to have at the top of your scripT

# MISC
# vars are global by default, designate local with 'local' keyword preceding, use -n to make it a pointer to arg passed in
# Single quotes for literal. Double quotes for var expansion.
# use "sleep" to pause a script briefly
# favor printf over echo, has better formatting and allows escape chars
#
[:] # for an infinite loop
# & tells bash to run the preceding command in the bg
# !! runs last command
# !v runs last command that started with "v"
# !$ expands to the last file used in command
#
# use your commands right in if statement to check for exit code
basename # strips dir
dirname # strips file

source ./file.sh
. ./file.sh
./file.sh  # this runs in a subshell, others do not

## create array
my_arr=(1 2 3 "four" 5)
## print array length
echo ${#my_arr[@]}

# There are some useful built-in variables, like:
echo "Last program's return value: $?"
echo "Script's PID: $$"
echo "Number of arguments passed to script: $#"
echo "All arguments passed to script: $@"
echo "Script's arguments separated into different variables: $1 $2..."


# TEMP FILE
tempfile=$(mktemp)
## explicit cleanup
trap "rm -f $tempfile" EXIT
## temp dir
tempdir=$(mktemp -d)


# FILE DESCRIPTORS
# a file descriptor is a number that represents an open file or resource; like pointers to sources of data
# linux treats everything like a file, even stdin, stdout, stderr
# 0 is stdin
# 1 is stdout
# 2 is stderr
read LINE 0< file.txt  # explicit designation of stdin
head file.txt 2> file2.txt  # redir stderr to file
head file.txt 2> /dev/null  # redir to the void
head file.txt &> file2.txt  # redir stderr and stdin
head file.txt |& command # redir stnin and stderr through pipe  
head file.txt 2>&1  # redir stderr into stdout  



# SHORT CIRCUITING
command && command   # 2nd command only runs if 1st does
command || command   # 2nd command runs if 1st fails, doesn't run if it succeeds
command ; command    # sep commands
command & command    # 2nd comm does not wait for the first to finish

exit 0  # give your script its own exit code

# COMPARISON
# compare strings with == and !=
# There are other comparison operators for numbers listed below:
# make sure to leave spaces in brackets
## -ne - not equal
## -lt - less than
## -gt - greater than
## -le - less than or equal to
## -ge - greater than or equal to


## accept user input
read -p "Prompt to show the user: " VAR_TO_STORE_ANSWER_IN


# PARAMETER EXPANSION
echo ${#var}  # length of var
${var_to_check_for:-"default to use instead"}  # use default if empty, does not assign
${parameter:="string or var"}  # assign new value if empty
${parameter:?"not set"}  # send to stderr
${parameter:+other_var}  # if null, don't sub. if not null, sub
echo ${string:7:2}  # echo 7th position plus 2 char forward (offset)
echo ${string:-7:-2}  # indices from end of array
echo ${array[@]:7:2}  # echo elements from an array range


## REDIRECTs
ls > file.txt # redirect stdout
read LINE < file.txt # redirect stdin (read takes in input from file instead of somehwere else, read only reads one line)
# use pipe when you want to redirect stdin from a command, and < for from a file. 


# CONDITIONALS
# best to use quotes around vars and strings in conditional statements 
if [[ condition ]] && [[ otherCondition ]] || [[ thirdCondition ]]; then
# can als us [[ condition -a otherCondition ]] for and; -o for or
    command;
else
    command;
fi

# alt conditional
[[ -z "$EDITOR" && EDITOR=nvim ]]

# to eval the exit code of a command
if ls &> /dev/null; then  # dev/null kills output to screen. if ! ls; for inversion
  break
fi
# do the same but store in a var too
output=$(make mytarget)
status=$?

if [ $status -ne 0 ]; then
  echo "Build failed"
  echo "Command output was: $output"
fi
 

# CASE / SWITCH
case "$VAR" in
    val)
        command
        ;;
    val2|val3)
        command
        ;;
    *)
      # catch all
      exit 1
      ;;
esac


# LOOPS
## conditions can contain a command that returns an exit status
## for loop
    for VAR in $LIST; do
        command
    done

    for item in $my_arr[@]; do
      command
    done
## c style
for ((i=0; i<0; i++)); do
  echo "$i"
done
## range
for i in {1..10}; do
  echo "$i"
done
## pattern matching
for item in ./things/*.md; do
  echo "$item"
## command sub
for item in $(ls); do
  echo "$item"
done

# while loop
#use "read" to read line by line
    while read -r line; do COMMAND; done < input.file
    # The -r option passed to read command prevents backslash escapes from being interpreted.
    # use IFS= before read to make sure whitespace is maintained

while [[ $counter -lt 5 ]]; do
  echo "$counter"
done

# you can also pipe into a while loop
# WARNING: this creates a sub shell
    grep whatever | while read LINE
    
# place sequencial words into their own vars per line
while read FIRST SECOND RESTOFLINE


# File conditions
# [[ -e FILE ]]	Exists
# [[ -r FILE ]]	Readable
# [[ -h FILE ]]	Symlink
# [[ -d FILE ]]	Directory
# [[ -w FILE ]]	Writable
# [[ -s FILE ]]	Size is > 0 bytes
# [[ -f FILE ]]	File
# [[ -x FILE ]]	Executable
# [[ FILE1 -nt FILE2 ]]	1 is more recent than 2
# [[ FILE1 -ot FILE2 ]]	2 is more recent than 1
# [[ FILE1 -ef FILE2 ]]	Same files

# [ -a existingfile ]	file 'existingfile' exists.	if [ -a tmp.tmp ]; thenrm -f tmp.tmp # Make sure we're not bothered by an old temporary filefi
# [ -b blockspecialfile ]	file 'blockspecialfile' exists and is block special.	Block special files are special kernel files found in /dev, mainly used for ATA devices like hard disks, cd-roms and floppy disks.if [ -b /dev/fd0 ]; thendd if=floppy.img of=/dev/fd0 # Write an image to a floppyfi
# [ -c characterspecialfile ]	file 'characterspecialfile' exists and is character special.	Character special files are special kernel files found in /dev, used for all kinds of purposes (audio hardware, tty's, but also /dev/null).if [ -c /dev/dsp ]; thencat raw.wav > /dev/dsp # This actually works for certain raw wav filesfi
# [ -d directory ]	file 'directory' exists and is a directory.	In UNIX-style, directories are a special kind of file.if [ -d ~/.kde ]; thenecho "You seem to be a kde user."fi
# [ -e existingfile ]	file 'existingfile' exists.	(same as -a, see that entry for an example)
# [ -f regularfile ]	file 'regularfile' exists and is a regular file.	A regular file is neither a block or character special file nor a directory.if [ -f ~/.bashrc ]; thensource ~/.bashrcfi
# [ -g sgidfile ]	file 'sgidfile' exists and is set-group-ID.	When the SGID-bit is set on a directory, all files created in that directory will inherit the group of the directory.if [ -g . ]; thenecho "Created files are inheriting the group '$(ls -ld . | awk '{ print $4 }')' from the working directory."fi
# [ -G fileownedbyeffectivegroup ]	file 'fileownedbyeffectivegroup' exists and is owned by the effective group ID.	The effective group id is the primary group id of the executing user.if [ ! -G file ]; then # An exclamation mark inverts the outcome of the condition following itchgrp $(id -g) file # Change the group if it's not the effective onefi
# [ -h symboliclink ]	file 'symboliclink' exists and is a symbolic link.	if [ -h $pathtofile ]; thenpathtofile=$(readlink -e $pathtofile) # Make sure $pathtofile contains the actual file and not a symlink to itfi
# [ -k stickyfile ]	file 'stickyfile' exists and has its sticky bit set.	The sticky bit has got quite a history, but is now used to prevent world-writable directories from having their contents deletable by anyone.if [ ! -k /tmp ]; then # An exclamation mark inverts the outcome of the condition following itecho "Warning! Anyone can delete and/or rename your files in /tmp!"fi
# [ -L symboliclink ]	file 'symboliclink' exists and is a symbolic link.	(same as -h, see that entry for an example)
# [ -N modifiedsincelastread ]	file 'modifiedsincelastread' exists and was modified after the last read.	if [ -N /etc/crontab ]; thenkillall -HUP crond # SIGHUP makes crond reread all crontabsfi
# [ -n ] non-empty string check
# [ -O fileownedbyeffectiveuser ]	file 'fileownedbyeffectiveuser' exists and is owned by the user executing the script.	if [ -O file ]; thenchmod 600 file # Makes the file private, which is a bad idea if you don't own itfi
# [ -p namedpipe ]	file 'namedpipe' exists and is a named pipe.	A named pipe is a file in /dev/fd/ that can be read just once. See my bash tutorial for a case in which it's used.if [ -p $file ]; thencp $file tmp.tmp # Make sure we'll be able to readfile="tmp.tmp"    # the file as many times as we likefi
# [ -r readablefile ]	file 'readablefile' exists and is readable to the script.	if [-r file ]; thencontent=$(cat file) # Set $content to the content of the filefi
# [ -s nonemptyfile ]	file 'nonemptyfile' exists and has a size of more than 0 bytes.	if [ -s logfile ]; thengzip logfile    # Backup the old logfiletouch logfile # before creating a fresh one.fi
# [ -S socket ]	file 'socket' exists and is a socket.	A socket file is used for inter-process communication, and features an interface similar to a network connection.if [ -S /var/lib/mysql/mysql.sock ]; thenmysql --socket=/var/lib/mysql/mysql.sock # See this MySQL tipfi
# [ -t openterminal ]	file descriptor 'openterminal' exists and refers to an open terminal.	Virtually everything is done using files on Linux/UNIX, and the terminal is no exception.if [ -t /dev/pts/3 ]; thenecho -e "nHello there. Message from terminal $(tty) to you." > /dev/pts/3 # Anyone using that terminal will actually see this message!fi
# [ -u suidfile ]	file 'suidfile' exists and is set-user-ID.	Setting the suid-bit on a file causes execution of that file to be done with the credentials of the owner of the file, not of the executing user.if [ -u executable ]; thenecho "Running program executable as user $(ls -l executable | awk '{ print $3 }')."fi
# [ -w writeablefile ]	file 'writeablefile' exists and is writeable to the script.	if [ -w /dev/hda ]; thengrub-install /dev/hdafi
# [ -x executablefile ]	file 'executablefile' exists and is executable for the script.	Note that the execute permission on a directory means that it's searchable (you can see which files it contains).if [ -x /root ]; thenecho "You can view the contents of the /root directory."fi
# [ -z string/file/array ]  checks if file or string is zero length



# WILDCARDS
# * matches zero or more
# ? matches exactly one char
# [] matches one char inside, like regex
# [!] negative matches
# [a-f] ranges
# [[:alpha:]] [[:digit:]] char classes, upper, lower, alnum, space, etc.

for FILE in /var/www/*.html
do
  echo "$FILE"
done


# GETOPTS
# allow your script to take in flags
# convention is to use a while loop

while getopts vl:s VAR_NAME  # vls are the flags to check for. Colon makes vl mandatory.
do
  case $(VAR_NAME) in
    v)
      VERBOSE='true'
      ;;
    l)
      LENGTH="${OPTARG}"
  esac
done

OPTIND # stores the index of an argument following the options, good for accessing post options args
# use "shift" to remove args 1-by-1


# ARITHMETIC EXPANSION (math)
NUM=$(( 1 + 2 ))
# can alternativeley use "let"
let NUM='1 + 2'
let NUM++
# or expr

# to increment
((INDEX++))



# LOGGING
# syslog is a Linux standard that integrates with any app
# Facilities: what type of log to use, if unsure, use "user" or "local"0-7
# Severities: level of error
# These can both send the logs to different files on your sys
# var/log/*

logger "message"
logger -p facilty.severity "message"
logger -t myscript   # adds a tag for easy searching in log file
logger -s           # sends message to screen
logger -            # adds PID


# DEBUGGING
## print tracing or x-tracing - add x to shebang line
#!/bin/bash -x
set -x      to do it from the command line
set +x      to kill
# these can be added inline to your script as well

# adding "-e" will make your script exit if any command has a non-zero exit code
# "-v" is same as x but does not expand vars and commands, shows them as is
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
e   use multiple commands
f   use a script file for sed commands
d   delete

## edit in place and create backup (insensitive)
sed -i.bak 'patterns' file.txt

## can use any delimiter
sed 's#serach#replace#gi' file.txt

## delete a specific line
sed '/searchPatter/d' file.txt
## delete blank lines
sed '/^$/d' file

## combine multi commands with ;
sed '/search/d ; otherSearch/d' file.txt
OR
sed -e 'command1' -e 'command2' file.txt

## use a script
sed -f script.sed file.txt

## replace only specific line
sed '3 s/search/replace' file.txt

## range
sed '1,32 s/search/replace' file.txt

## replace lines containing certain pattern
### also works with range; can use range from one regex to another
sed '/containingPatter/ s/search/replace' file.txt


# CUT
# cuts out section form each line it receives and displays, extract columns from csv
# only splits on single char

# -c specifies char in line
cut -c 4-7 file.txt
cut -c 4- file.txt
cut -c -4 file.txt  # displays first four char
cut -c 1,3,5 file.txt

# -f is for tabs/fields
cut -f 3  # selects 3rd field
cut -f 1,3  # selects 1st and 3rd field
cut -d ',' -f 3  # specify delimiter
cut -d, -f 3  # specify delimiter

# --output-delimiter

# AWK
# field spearator is whitespace by default, good for trimming
# iterates over file one line at a time
# also good for multi-char separator
# separate commands with ;
awk -F  # field delimiter
awk -F ',' '{print $1 "some string" $3'}  # prints fields 1 and 2
# can also do the above by setting the OFS (output field separator)
# {print $NF} prints the last field, can use math to do offsets

# print current line completely
awk '{print $0}'

# conditionals/ternary
awk '{print ($1=="thing" ? "thing" : "otherthing")}'
awk '(NR==1){print "this is line one: "$0} (NR==2){print "this is line 2: "$0}'
# parenth optional
awk 'NR==1{print "this is line one: "$0} NR==2{print "this is line 2: "$0}'
# print lines greater than 3
awk 'NR>3{print}'
# regex (ends in e)
awk '($0 ~ /e$/){print}' file.txt
# same but simpler
awk '/e$/' file.txt

# NR
# number of records, kinda like getting array.length
# can also be used to refer to specific lines in a conditional: NR==1

# use printf for more formatting


# JQ
jq '.' file  # output whole object
jq '..' file  # output every iteration of objects
jq '.field' file  # just that field
jq '.field' file -r  # text output instead of json
jq '.user.name' file  # nexted field
jq '.user.name, .user.id' file  # sel multi fields

# array iteration
jq '.[]' file  # pull objects out of array
jq '.[1]' file  # get certain index
jq '.[1:4]' file  # range
jq '.[-2:]' file  # last 2 el

jq '.[] | .user, .name' file  # pipe within expression
jq '.[] | .points = 2' file  # add a field
jq '{ newVal: .oldVal }' file  # rename field
jq keys file  # get keys, can use after a pipe too

...       length file

jq '. | map(.title += "thing")'  # remap or append a val
jq '.[] | select(.id >= 197)'  # filter
jq 'select(has(.logs))' file  # filter by certain key
jq 'select(values.a)' file  # select values
jq 'select(any(contains("something")))'
jq '.[] | if (.id % 2) then .points = "even" else . end'  # conditional. use "and" and "elif" for more options



















