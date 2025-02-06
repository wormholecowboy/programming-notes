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





