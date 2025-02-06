
# CUT
# cuts out section fromm each line it receives and displays, extract columns from csv
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


