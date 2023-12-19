
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


