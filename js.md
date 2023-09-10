# Js - Javascript

Created: January 27, 2022 6:14 PM
Updated: October 1, 2022 10:04 PM

![Untitled](Js%20-%20Javascript%20baec6f3414044f299d30fed95115e041/Untitled.png)

- Misc Advice
  - In native JavaScript, you can only assign values to variables. You can’t assign variables to reference another variable, even though it looks like you can. In native JavaScript: **a variable can only reference an actual value; it can’t reference another variable**.
    - primitives like string and number are pass by value. They just take the value of a variable and copy that value to the new variable. Changing the 2nd variable WILL NOT change the 1st.
    - objects and array are the opposite. They are pass by reference. Objects can’t actually be assigned to a variable. The variable only gets a reference to the object in memory. So editing a copy of a variable assigned an object will change the original, and vise versa.
  - Most string methods don’t mutate. Must reassign instead.
  - you can use ‘in’ keyword to check if prop exists inside an object
  - You can pretty much always use spread syntax instead of push , splice , or concat. Does not mutate.
  - To dedupe an array, simply do return [...new Set(array)];
  - When you reassign a primitive, it actually creates a copy of the variable and just dumps the old one. The original variable never gets reassigned, just abandoned.
  - only use == when checking null, otherwise use ===
    - same goes for “!==”
  - you can defer loading a script in the head so the page elements load first
    -
    ```jsx
    <script src="script.js" defer></script>
    ```
- Use obj if fn has too many params
  - Can also use spread operator on param, then access arguments as an array

oPERATOR PRECEDENCE
The AND operator has a higher precedence than the OR operator, meaning the && operator is executed before the || operator

-MODULO

```jsx
// keep something within bounds of an array's length

let value = array[i % array.length];
```

-GENERATOR

```jsx
// grabs values from an array over time, allows you to stop a function, run it piece by piece

function* generatorFunc{array) {
	// code
	yield 1
	// code
	yield 2
	// code
	yield 3
}

let gen = generatorFunc();
console.log( gen.next() );
console.log( gen.next() );
console.log( gen.next() );
```

-COMPUTED PROPERTIES

ES6 allows you to use an expression in brackets `[]`. It’ll then use the result of the expression as the property name of an object.

-CONSOLE

```jsx
// see the object name in console - use curlies
console.log({objName})

// make things stand out with CSS
console.log('%c some text', 'color: orange; font:arial'

// console table
console.table([array, orObjects])

// measure time of execution
console.time('timerName') // timer definition

someFunction();

console.timeEnd('timerName') // trigger end of timer

// add a stack trace to your function

function someFunc() {
	// func
	console.trace('your console message')
}
```

-OBJECT PROP SHORTHAND

```jsx
// if you want to define an object who's keys have the same name as the variables passed-in as properties, you can use the shorthand and simply pass the key name.

var cat = 'Miaow';
var dog = 'Woof';
var bird = 'Peet peet';

var someObject = {
  cat,
  dog,
  bird,
};
```

-FOR OF vs FOR IN

Both `for..of` and `for..in` statements iterate over lists; the values iterated on are different though, `for..in` returns a list of keys on the object being iterated, whereas `for..of` returns a list of values of the numeric properties of the object being iterated.

Here is an example that demonstrates this distinction:

```jsx
let list = [4, 5, 6];

for (let i in list) {
  console.log(i); // "0", "1", "2",
}

for (let i of list) {
  console.log(i); // "4", "5", "6"
}
```

Another distinction is that `for..in` operates on any object; it serves as a way to inspect properties on this object. `for..of` on the other hand, is mainly interested in values of iterable objects. Built-in objects like `Map` and `Set` implement `Symbol.iterator` property allowing access to stored values. For..of does not work on objects.

```jsx
let pets = new Set(['Cat', 'Dog', 'Hamster']);
pets['species'] = 'mammals';

for (let pet in pets) {
  console.log(pet); // "species"
}

for (let pet of pets) {
  console.log(pet); // "Cat", "Dog", "Hamster"
}

Object.keys(obj);
// Returns an array with a list of the keys as strings.
Object.values(obj);
// Returns an array with a list of the values as strings.
Object.entries(obj);
// Reuturns both the key and value in its own array
// You can also use this to iterate over the key/value at the same time using destructuring of the array
for ([k, v] of Object.entries(obj)) {
}
```

- Use `let` in `for` loops, `const` in `for..of` and `for..in`
- don’t use for…in for arrays, use forEach instead
- use array.entries() in for…of if you want to use the indicies too.
- The `for...in` iterates over all [enumerable properties](https://www.javascripttutorial.net/javascript-enumerable-properties/) of an object. It doesn’t iterate over a collection such as `Array`, `Map` or `Set`.
- For…in will include the protoype props, so usually avoid it
- Unlike the `for...in` loop, the `for...of` iterates a collection, rather than an object. In fact, the `for...of` iterates over elements of any collection that has the `[[Symbol.iterator]](https://www.javascripttutorial.net/es6/symbol/#iterator)` property.
- You can label loops: `loop2: for(let x of something) {}`

-EVENT LOOP

checks call stack, executes what's there, and adds from event queue if all have been executed in stack. Callbacks/promises get pushed from event stack to event table. When ready, they get pushed to event queue to wait to got into the stack again.

-HOISTING

- a *lexical environment* is a place where variables and functions live during the program execution. So you can ref before declaring.
- Hoisting is when the js engine parse code and moves all variables and functions to top of their scope.
- declaring a variable is just reserving that name in memory. initializing is setting a value.
- JavaScript only hoist declarations, not initializations*.* That is, during compile time, JavaScript only stores function and variable declarations in the memory, not their assignments (value).
- Var is hoisted as undefined
- All declarations (function, var, let, const and class) are hoisted in JavaScript, while the `var`declarations are initialized with `undefined`, but `let` and `const` declarations remain uninitialized.
- We can reference the `let` and `const`variables in the code (eg. function body ) even before they are declared, as long as that code is not executed before the variable declaration
- Classes work like let and const
- NOTE: ‘let’ will not create a property on the global object like ‘var’ does

-TEMPORAL DEAD ZONE

- declare let/const outside conditional. assignments inside conditional braces won't carry back outside
- Accessing variable before declaring: let/const will throw error, var undefined. This is the temporal dead zone. Where variables are in scope, but not yet declared, unreachable.

-THIS KEYWORD (weird behavior)

- **The value of `this` inside a function depends on *how* the function is called, NOT *where* the function is defined. So if you call it outside of the object, it will reference the window, NOT the object.**
- THIS references whatever object calls it. (execution context)
- It will not capture props in a object and work when called outside object. You have to call it with dot notation.
  - Use bind to specifiy what object you want THIS to be bound to
  - `let boundFn = someFn.bind(someObj);`
- **the value of `this` in an arrow function depends on where the function is defined. Therefore, it cannot be changed at runtime!**
  - arrow function does not create its own [execution context](https://www.javascripttutorial.net/javascript-execution-context/) but inherits the `this` from the outer function where the arrow function is defined.
  - AVOID using arrow functions to define methods for this reason
- THIS does work inside of addEventListener. It will reference the element.
- Constructors automatically bind THIS to objects
- strict mode: this referencing global/window will return undefined
- IF you want to chain methods while retaining THIS, just return THIS from each method

-CLOSURE

- A closure is a function that preserves the outer scope in its inner scope. An inner scope will even retain a variable from an outer function, even if it has finished running.
- [https://www.javascripttutorial.net/javascript-closure/](https://www.javascripttutorial.net/javascript-closure/)
- Lexical(static) scoping: Outer variables are accessible inside, but not the other way around. Scopes can be nested.
- A function will memorize the available variables in its closure during hoisting, but looks up the value at runtime!!
- Even if you take an inner function out of its lexical scope, it will remember its scope. ex:

```jsx
function outerFunc() {
  let outerVar = 'I am outside!';
  function innerFunc() {
    console.log(outerVar); // => logs "I am outside!"
  }
  return innerFunc;
}
function exec() {
  const myInnerFunc = outerFunc();
  myInnerFunc();
}
exec();

// innveFunc is out of lexical scope or closure, but remembers outerVar
```

the closure is a function that remembers the variables from the place where it is defined, regardless of where it is executed later.

A rule of thumb to identify a closure: if inside a function you see an alien variable (not defined inside that function), most likely that function is a closure because the alien variable is captured.

-SPREAD OPERATOR ...

- Feeds all elements of an array or object to something one at a time. It’s iterable.
  - ex. Say you need to feed each number from an array into some arguments for a function
- Syntax: ...arrayName

```jsx
1
myFunction(...iterableObj); // pass all elements of iterableObj as arguments to function myFunction
2
[...iterableObj, '4', 'five', 6]; // combine two arrays by inserting all elements from iterableObj
3
let objClone = { ...obj }; // pass all key:value pairs from an object
		// This is a great way to make a copy of an object and not worry about reference issues. This only works "shallowly"
```

-SWITCH, CASE, BREAK

```jsx
// Switch, Case, Break

let a = 2 + 2;

switch (a) {
  case 3:
    alert('Too small');
    break;
  case 4:
    alert('Exactly!');
    break;
  case 5:
    alert('Too big');
    break;
  default:
    alert("I don't know such values");
}
```

-TERNARY OPERATOR

```jsx
// ?  TERNARY OPERATOR: A shorter if statement

// ? is "then"
// : is "else"

// SYNTAX
let variable = (expression) ? insertedValueA : insertedValueB;

let accessAllowed;
let age = prompt('How old are you?', '');

if (age > 18) {
  accessAllowed = true;
} else {
  accessAllowed = false;
}

// IS THE SAME AS:

let accessAllowed = (age > 18) ? true : false;

// values after "?" are inserted into variable based on conidtional statement

// MULTIPLE

let variable = (condition) ? 'value' : (condition) ? 'value' : (condition) ? 'value' : (condition) ? 'value' : (condition) ? 'value'

// OPTIONAL CHAINING
// ? will turn anthing before it into a conditional (IF)
// It helps to stop errors from happening, say by validating that something exisits

document.getElementsByID('idThatIReallyHopeExists')?.value;
```

?? -NULLISH COALESCING OPERATOR

```jsx
// ?? Nullish Coalescing Operateor
// It returns the first variable that is NOT undefined or null

result = a ?? b;

// IS THE SAME AS

result = a !== null && a !== undefined ? a : b;

// good for using in place of ||, when you might get passed zero and run into implicit type cohersion
```

? -OPTIONAL CHAINING

```jsx
// checks each object or prop in the chain to see if it is null or undefined
// if it's not, then it continues to the next prop

console.log(person?.address?.street?.number);

// can check if methods or arrays exist too

obj.doSomething?.();

brian.hobbies?.[0];
```

-DESTRUCTURING

```jsx
const { fname, lname, address:{city} } = person;

// will pull out of 'person' object and make variables of each

// ARRAY DESTRUCTURING: assign variable names to array elements

const [booties] = ['boots', 'tent', 'firestarter'];
console.log(booties);
// boots

const [,, beavis] = ['boots', 'tent', 'firestarter'];
console.log(beavis);
// firestarter

use colon to rename vars
```

-CLASSES

- subclasses must always call super in their constructor

```jsx
class MyClass {
  constructor() {}
}

//under the hood, you are just creating a function like this
function MyClass() {}
```

-HIGH ORDER ARRAY METHODS

```jsx
array.forEach(function (iteratorVar) {
  console.log(iteratorVar.someProperty);
});

//map will return whatever into a new array

const newArray = oldArray.map(function (iteratorVar) {
  return iteratorVar.someProperty;
});

//filter return a new array based on a condition

const newArray = oldArrary.filter(function (iteratorVar) {
  return conditional;
});

// you can stack these methoods like so....

const newArray = oldArrary
  .filter(function (iteratorVar) {
    return conditional;
  })
  .map(function (iteratorVar) {
    return iteratorVar.someProperty;
  });
```

-PROTOTYPES

```jsx
// Relying on protoypes saves on memory. If looking for a func or prop, the engine will keep looking up the chain until it finds it. So default methods are inherited from a single master object, like 'forEach'.

/* PROTOTYPE CHAIN

yourObj --> objClassItInheritedFrom --> Object.prototype --> null

*/

// INSPECT A PROTOTYPE (not standard, use in dev only)
console.log(myObject.__proto__);
// OR
Object.getPrototypeOf(someOjb);

// INHERIT ANOTHER OBJECT
const user = Object.create(inheritedObject);

// ADJUST AN OBJECT'S PROTOTYPE
Object.setPrototypeOf( objToChange, { prop: 'value' } );

// CHANGE PROTOTYPE FOR INSTANTIATED (FUNCTIONS WITH CONSTRUCTORS)
Person.prototype = human;
// all instantiated objects from 'Person' will have the 'human' prototype

// ADD A METHOD TO PROTOTYP
Person.prototype.methodToAdd = funciton() {}
// won't work on something that was instantiated

// prototype chain

// __proto__

// null

// clone an object (with prototype)
Object.create(oldObj);

// clone object (without prototyp) inner references stay as references
Object.assign(oldObj);
// you can also use the spread syntax to do the same
newObj = {...oldObj, a="whatever"}

```

-DOM

```jsx
// selecting multpile elemnts
document.querySelectorALL('.className');

// remove an element
variable.remove();

// edit content

variable.textContent = 'new string';

variable.innerText = 'new string';

// select the child of a parent

variable.children[arrayIndexNumber] = 'whatever';

// grab the first element or class
document.querySelector('p');
// grab all of them
document.querySelectorAll('.someClass');

// change css for a variable

const element = document.querySelector('.class');
element.style.background = 'red';
```

-ASYNC AWAIT, -PROMISES

```jsx

//PROMISES
// note: axios is a library for getting data from URLs
//
// Promises run in micro queue. They still run code on main thread, only the resolution is run asyncronously. If you want to delay the code being run, put it inside a .resolve().then()

axios
	.get("someURL.html")
	.then(function(response) {
		// now i have data
		return axios.get("someURL.html")
	})
	.then(function(response) {
		// now i have data
		return axios.get("someURL.html")
	})
	.then(function(response) {
		// now i have data
		return axios.get("someURL.html")
	.catch(function() {
		//error handling
	})
	})
// You can chain these instead of nesting in callback hell

// PROMISES
// Promise takes a function with 2 arg, res and rej

let p = new Promise((resolve, reject) => {
	let a = 1 + 1;
	if (a == 2 ) resolve('it worked!')
	else reject('nah')
}

p.then((returnFromResolve) => {
	// do something with the resolve argument
	// this runs if it resolves
	console.log(returnFromResolve);
}).catch((returnFromReject) => // runs if rejected)

// run promise.all if you want to run all awaits concurrently (they are not dependent on each other) no awaits on the individuals

Promise.all([promise1, promise2, promise3])
	.then((arrayOfPromisesResolves) => //do things);

// Promise.race does the same, but only uses the first promise to resolve
Promise.race([])

// If you want to avoid gumming up the main thread with a bulky promise, put the function after a resolve in a .then.
return Promise.resolve().then( () => {} )

// ASYNC AWAIT
// Sticks your awaiting data into variables for use when ready
//
// returns are automatically promises
// await is like a pause button on the function

async someFunction() {
	var response1 = await axios.get("someURL1");
	var response2 = await axios.get("someURL2");
	var response3 = await axios.get("someURL3");
}

try{}
catch{} //replaces the .then and .catch from promises

//
// async doesn't pause in loops and mapping when inside
// keep async outside the for loop
// can all use "for await ()"

for await (const v of someArray) {}

// can use in conditionalss too
if (await fn() === a) {}

// can use Promise.all with async too to avoid blocking code
// vars are returned in the order of the promise.all arrary

async function whatever() {
	const a = somefunc();
	const b = otherfunc();
	const combo = await Promise.all([a,b])

	return combo
}

```

IIFE: immediately invoked function expression

```jsx
(function () {
  //...
})();
```

-ARRAY

```jsx
// ARRAY METHODS

const array = []

array.push() // add to end
array.pop() // deelete from end
cosnt.shift() // dleete from beginning
array.unshift()//

array.splice(2, 0, "lemon", "kiwi") // add 2 items at index 2
array.splice(3, 4) // delete 4 items starting at index 3
array.splice(2, 1, "something") // replace 1 item starting at index 2

array.sort()
array.reverse()

arrary.concat(secondeArraryName)

array.slice(1,5) // returns index values 1-4
arrary.slice(-4,-1) // count backwards from the end (non-zero based)

/*

- Some() vs. Includes()
    - Includes() will just look for a string in an array, while Some() will look to see if an element passes a test(generally tested with a function) */
variable.includes('someString');
variable.some(function(){});

/*
- Every() - Makes sure every element in an array passes a test, otherwise returns false. */
array.every(function(currentValue, index, arr), thisValue)

// Filter() creates a new array with all elements that pass the test.
array.filter(function(currentValue, index, arr), thisValue)

// Map() same as filter, but allwos you to modify items
array.map(function(currentValue, index, arr), thisValue)

// The map method is used to convert each item of an array, while the filter method is used to select certain items of an array. Filter will not change values.

//Reduce() Returns a single value, reduces array to one value after processing
variable.reduce( (totalValue, currentValue) => dothingstovalues() )

```

-MODULE ES6 IMPORT EXPORT

- it’s possible to dynamically import things needed in specific scenarios, only when its needed: import()
- You can only default export one from each file
- ./ is relative path
- / is absolute path

![Untitled](Js%20-%20Javascript%20baec6f3414044f299d30fed95115e041/Untitled%201.png)

-

![Untitled](Js%20-%20Javascript%20baec6f3414044f299d30fed95115e041/Untitled%202.png)

![es6-module-cheatsheet.jpeg](Js%20-%20Javascript%20baec6f3414044f299d30fed95115e041/es6-module-cheatsheet.jpeg)

-BIND, CALL, APPLY

- BIND will is used to create a new function with THIS explicitly bound to certain obj.
- CALL & APPLY can change THIS also, but not create a new fn.
  - Call takes obj, then the functions args: `someFn.call(newObjRef, arg1, arg2, arg3)`
  - Apply does the same, but 2nd arg is array: `someFn.apply(newObjRef, [a1, a2, a3]`
  - Call is more common b/c of spread syntax: `someFn.call(newObjRef, ...[a1, a2, a3])`

-SETS & -MAPS

- Sets are a unique value array
- Maps are key value pairs

```jsx
// SETS
// unordered arrays, and cannot store duplicate values.

// Declare
var set = new Set([1, 2, 3])

// Properties
set.size

// Not to be confused with set.length which will return undefined
//Iteration
for (const item of set) { function }

// Methods
set.add(val);
set.delete(val);

// Wow, so much easier than removing from array!

set.has(val);

// MAPS
let something = new Map( [ ['key', 'value'], ['key2', 'value2'] ] );
```
