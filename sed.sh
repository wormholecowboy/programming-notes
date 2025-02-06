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
sed '/containingPattern/ s/search/replace' file.txt


