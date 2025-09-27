
# FINDING
find <dir> -iname <file> This will be case insensitive
find . -name "file.txt"
find . -empty <!-- # find empty files -->
find . -iname "*usingwildcards*"
-type d searches only dir
-type f searches only files
find ~ \( -iname '*jpeg' -o -iname '*jpg' \) using the OR flag -o



