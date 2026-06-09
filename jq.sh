# SYNTAX
`.`         // identity / current value (whole input)
`.foo`      // access field "foo"
`.foo.bar`  // nested field access
`.[]`       // iterate: emit each element of array/object
`.[N]`      // index into array (N can be negative)
`.[A:B]`    // slice array from A to B
`|`         // pipe: feed left output into right expression
`,`         // emit multiple results from one input
`( )`       // group expressions
`[ ... ]`   // collect results into an array
`{ ... }`   // construct an object
`$name`     // variable (set via --arg / --argjson / `as`)
`-r`        // raw output (strip JSON quotes)
`-c`        // compact output (one line per value)
`-s`        // slurp: read all inputs into one array
`-n`        // null input: don't read stdin/file

# BASICS
`jq '.' file`              // output whole object
`jq '..' file`             // recurse every value
`jq '.field' file`         // single field
`jq '.field' file -r`      // raw text (no quotes)
`jq '.user.name' file`     // nested field
`jq '.user.name, .user.id' file`  // multiple fields

# ARRAYS
`jq '.[]' file`            // iterate array elements
`jq '.[1]' file`           // index
`jq '.[1:4]' file`         // slice range
`jq '.[-2:]' file`         // last 2 elements
`jq 'length' file`         // array/object/string length
`jq 'keys' file`           // object keys (sorted)
`jq 'keys_unsorted' file`  // keys in original order

# PIPES & TRANSFORM
`jq '.[] | .user, .name' file`        // pipe within expression
`jq '.[] | .points = 2' file`         // set/add field
`jq '{ newVal: .oldVal }' file`       // rename / reshape
`jq '. | map(.title += "thing")' file`  // append to each
`jq 'map({id, name})' file`           // pick fields from each
`jq '.[] | del(.field)' file`         // delete field

# FILTER / SELECT
`jq '.[] | select(.id >= 197)' file`            // filter by predicate
`jq '.[] | select(has("logs"))' file`           // has key
`jq '.[] | select(.name | contains("foo"))' file`  // substring match
`jq '.[] | select(.tags | any(. == "x"))' file` // array contains
`jq '.[] | select(.field != null)' file`        // non-null

# CONDITIONALS
`jq '.[] | if (.id % 2) then .points = "even" else . end' file`  // if/else
`jq '.[] | if .a then .x elif .b then .y else .z end' file`      // elif chain

# COUNT / AGGREGATE
`jq 'length' file`                              // total count
`jq '[.[] | select(.active)] | length' file`   // count matching
`jq '[.[].status] | group_by(.) | map({key: .[0], count: length})' file`  // count by field
`jq 'group_by(.type) | map({type: .[0].type, count: length})' file`       // group + count
`jq '[.[].price] | add' file`                   // sum field
`jq '[.[].price] | add / length' file`          // average
`jq '[.[].price] | min, max' file`              // min/max
`jq '[.[].user] | unique' file`                 // distinct values
`jq '[.[].user] | unique | length' file`        // distinct count

# SORT
`jq 'sort' file`                       // sort array
`jq 'sort_by(.age)' file`              // sort by field
`jq 'sort_by(.age) | reverse' file`    // desc sort

# OUTPUT FORMATS
`jq -r '.name' file`                   // raw string (no quotes)
`jq -c '.' file`                       // compact (one line per obj)
`jq -s '.' file1 file2`                // slurp: combine inputs into array
`jq -n '{a:1, b:2}'`                   // null input, emit literal
`jq -r '.[] | [.id, .name] | @csv' file`  // CSV output
`jq -r '.[] | [.id, .name] | @tsv' file`  // TSV output

# VARS & ARGS
`jq --arg name "bob" '.[] | select(.user == $name)' file`  // string arg
`jq --argjson n 5 '.[] | select(.id > $n)' file`           // numeric/json arg
