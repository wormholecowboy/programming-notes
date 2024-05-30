
MISC

/* - Don’t annotate types where it would be inferred anyway
- Targets ES3 by default
- to disable errors: `tsc --noEmitOnError hello.ts`
- `npm install -g typescript`  `tsc -v`
- The strictness of TS can be dialed in. Recommended for new codebases. Set up in config.
    - **`noImplicitAny`: will flag any var that gets inferred as ‘any’**
    - **`strictNullChecks`: forces you to deal with any null/undefined checks**
- If not using a framework, you’ll need source and dist folders for transpiling
    - `type point = number | string`
    - can’t do this with interfaces
    - interfaces are more for objects
    - Prefer interfaces to types 
- classes: you can declare and assign fields right in the constructor parameters
  */

// -BASICS


// TYPES

// primitives
let a: number = 5
let b: string = 'Brian'
let c: boolean = true
let d: any = 10
let e: number[] = [1,2,3] // array of numbers
let f: any[] = [1,'poop',true] // any array

// tuple (must respect the order)
let f: [number,string,boolean] = [1,'poop',true]

// tuple array
let g: [number,string][]
g = [
	[1, 'Brian'],
	[2, 'Shannon'],
	[3, 'Jagger']
]

// union (var that holds more than one type)
let id: string | id = 22

// literal types
// use specific strings as values
type directions: "North" | "South"

// enum (set of named constants)
enum Direction1 {
	Up,
	Down,
	Left,
	Right = 'whatever'
} // by default will follow values of an index i.e. 0,1,2,3 
// can be strings or numbers, assignable, num will increment

// objects
let h: {} = {}
let h: {id: number} = {id: 2}
// alternative (define the type object)
type User = {id: number}
let h: User = {id: 2}

// custom types
type Thing = {
  name: string,
  id: number
}

// type assertion (tell the compiler to use a different type) 
let cid: any = 2;
let customerID = <number>cid;  // types customerID as number, does not work in tsx!!
// alternative
let customerID = cid as number
let customerId = (cid as string).trim()

// type declartions
// good for assigning types to things like process.env that are not defined in your file
declare const process: any;
// can keep these in sep file
filename.d.ts
// or you can just import a lib like @types/node

// type narrowing
type Square = {
  size: number,
};

type Rectangle = {
  width: number,
  height: number,
};

type Shape = Square | Rectangle;

function area(shape: Shape) {
  if ('size' in shape) {
    return shape.size * shape.size;
  }
  if ('width' in shape) {
    return shape.width * shape.height;
  }
}

// type intersection
type Person = {
  name: string,
};

type Email = {
  email: string,
};

type Phone = {
  phone: string,
};

type ContactDetails =
  & Person
  & Email
  & Phone;


// function
function addNum(x: number, y: number): number {
	return x+y;
} // return type goes after the parenth for params
// use 'void' for no return


// classes
class Person {
	constructor(id: number, name: string) {
		this.id = id;
		this.name = name;
	}
private id: number // can only be accessed within class
protected name: string // accessable buy extendable subclasses
readonly: age: number // readonly
someOtherProp: boolean
}

// class using an interface
class Person implements PersonInterface {}

// class extending a class
class Employee extends Person {
	position: string

	constructor(id: number, name: string, position: string) {
		super(id, name) // this sends those params to the superclass
		this.position = position;
	}
}

// Generics (used to build reusable components) 
// (choose type during assignement)

// TYPING A PARAM AS AN OBJECT

function whatever( { title }: { title?: string}) 
// ? makes it optional


//GENERICS
// Allows you to define the type later on, creates a placeholder during the definition
// ex. You can create a generic function for making arrays and define the type at runtime

function getArray<T>(items: T[]): T[] {
	return new Array().concat(items); }

// type defined inside function call
const numArray = getArray<number>([1,2,3,4])
const strArray = getArray<string>(['poop', 'butts']) 


// class
class Thing<T> {
  private name: T
}

thingy = new Thing<string>()


// -REACT
// - has a type called ‘FC’ for function component


// TYPING CHILDREN
// TYPING A PARAM AS AN OBJECT

function whatever( { children }: { children: ReactNode }): ReactElement
// ? makes it optional

// interface
interface CoolProps {
	name?: string
	id: number
}
const Cool:FC<CoolProps> () => {  // FC is funcion component type
	//whatever
}


// INTERFACES

// add a ? at the end of property name to make it optional
// Can pass the interface to a type like this:

// interface
interface CoolProps {
	name?: string
	id: number
	readonly age: number
} // name is optional here and age is not writeable

// interface with function
interface MathFunc {
	(x: number, y: number): number
}
const add: MathFunc = (x: number, y: number): number => x+y



// USER DEFINED TYPED GUARDS
// good for production code
// return definition tells ts if true, shape is a square
function isSquare(shape: Shape): shape is Square {
	return 'size' in shape;
}

// ASSERTION FUNCTIONS
// good for testing code
// tells ts that if returns true, value cannot be null
function assert(condition: unknown, message: string): asserts condition {
  if (!condition) throw new Error(message);
}

// tells ts that value must be Date
function assertDate(value: unknown): asserts value is Date {
  if (value instanceof Date) return;
  else throw new TypeError('value is not a Date');
}
