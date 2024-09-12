// MISC
// Strings use double quotes or backticks
// Return errors from fns is a go idiom
// all data types are initialized to something, 0 or nil usually
// arguments are pass by value (makes a copy), except slices, maps and channels

// build tags. Need blank line after.
//go:build prod || dev 

package main

import (
  "fmt"
  "errors"
  "strings"
)


func main() {
  // must have this in main package
  var thingy string = "whatever"
  fmt.Println("Print to console like this")
  fmt.Printf("Print a formatted %v", thingy)
}

func test() string {
  return "string"
}

func testFunc(x, y int) (int, int, error) {  // 2nd paren are return vars with types
    var err error = errors.New("some error") 
    if err != nil {
      return x+y, x*y, err
    }
    return x + y, x * y, err
}

// SWITCH
switch{
case true:
  //do thing
  // break is implicit
case false:
  // do things
default:
  // nothing
}

// switch with var
switch thing {
case 0:
  // do thing
default:
  // thing
}

// ARRAY
// fixed len, contiguous, same type, indexable

var intArr [3]int32 // array of 3 int32, all init to 0
fmt.Println(intArr[1:3]) // print indices 1 and 2

var intArr2 [3]int32 = [3]int32{1,2,3} // literal initialization
var intArr2 [3]int32 = [...]int32{1,2,3} // inferred
intArr3 := [...]int32{1,2,3} // even more concise


// SLICES
// wrappers around arrays that let you change them
// slices are copied by ref (they are actually pointers to arrays under the hood)
var intSlice []int32 = []int32{1,2,3}  // omitting number in brackets gives you a slice
intSlice = append(intSlice, 4)  // returns a new array at new mem location
intSlice = append(intSlice, intSlice2...)  // append multiple
len(intSlice) // how many members
cap(intSlice) // total capacity

var intSlice2 []int32 = make([]int32, 3, 6)  // specify len and cap


// MAPS
// unordered
var myMap map[string]uint8 = make(map[string]uint8)  // keys are strings and values are uints
var myMap2 = map[string]uint3{"Brian": 16, "Shannon": 15} // literal init
myMap2["Brian"]

// WARNING: maps will always return something, even if keys don't exist
var age, ok = myMap2["Jagger"]  // maps return 2nd element (bool) that you can use for checks

delete(myMap2, "Brian") // does not return anything


// FOR LOOPS
for name, age:= range myMap2 {  // i,v for index value in an array/slice
  fmt.Println("Name: %v", name, age)
}


// WHILE LOOPS
i := 0
for i<10{
  i = i + 1
}

// can also use break conditions 
for {
  if i >= 10 {
    break
  }
}

// or
for j:=0; j<10; j++{
  //
}


// STRINGS
// uses utf-8 encoding to represent strings 
// utf-8 uses variable byte sizes. first char of first byte tells how many bytes there are
myString = "thing"
thing[0] // can be indexed.  
// it is actually indexing the underlaying byte array, so will return decimal rep.
// if a char has more than one byte, indexing can be thrown off, be careful
// range kw will correctly deal with this

len(myString) // will take len of bytes, not char
// instead, cast string as a rune array, which is a unicode point number representing the char. Runes are just an alias for int32
myString2 = []rune("thing")
len(myString2)

// strings are immutable. concat creates a new on every time.
myString2 += myString
// instead, use strings
var strBuilder strings.Builder
strBuilder.WriteToString("thingy")
var newString = strBuilder.String()


// STRUCTS: custom types
type gasEngine struct {
  mpc uint8
  gallons uint8
  ownerInfo owner
}

type owner struct {
  name string
}

var myEngine gasEngine = gasEngine{mpg:25, gallons:15}
var myEngine gasEngine = gasEngine{25, 15} // can omit fields
myEngine.mpg = 5  // set directly

var myEngine gasEngine = gasEngine{mpg:25, gallons:15, owner{"Brian"}}
myEngine.ownerInfo.name

// alt
type gasEngine struct {
  mpc uint8
  gallons uint8
  owner // passes field directly to this level of hirearchy
}
myEngine.name

// anon struct
myEngine3 := struct{mpg int, gallons int}

// methods for structs
func (e gasEngine) gallonsLeft() uint8 {
  return e.gallons
}
myEngine.gallonsLeft()


// INTERFACE
// can set this as param so passed in structs must adhere to it
type engine interface {
  milesLeft() uint8
}


// POINTERS
// make sure to assign pointer to an address before ref
var p *int32   // creates pointer, init to nil, no ref yet
var p *int32 = new(int32)  // points to address with 0 inside
fmt.Println(*p)  // get the value of the address that p is pointing to (dereferencing the pointer)
*p = 10  // sets new value at address p is pointing to

var i int32
p = &i  // assign p the memory address of i
*p = 1  // value of i is also changed

// pass by ref or value
var thing1 = [3]float32{1,2,3}
passByvalue(thing1)
func passByvalue(param [3]float32) {
  // param will have a diff mem addr, makes a copy, pass by value
}

// instead, make the fn take in a pointer
func passByRef(param *[3]float32) {
  // param will mutate orig array
}
passByRef(&thing1)

