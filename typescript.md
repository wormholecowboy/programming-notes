# Typescript

Created: September 8, 2022 7:59 AM
Updated: October 1, 2022 11:25 AM

MISC

- Don’t annotate types where it would be inferred anyway
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

-BASICS

```tsx

// TYPES

// primitives
let a: number = 5
let b: string = 'Brian
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
let lockState = "locked" | "unlocked"

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

// type assertion (tell the compiler to use a different type) 
let cid: any = 2;
let customerID = <number> cid;  // types customerID as number
// alternative
let customerID = cid as number

// function
function addNum(x: number, y: number): number {
	return x+y;
} // return type goes after the parenth for params
// use 'void' for no return

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

// classes
class Person {
	constructor(id: number, name: string) {
		this.id = id;
		this.name = name;
	}
private id: number // can only be accessed within class
protected name: string // accessable buy extendable subclasses
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
```

-GENERICS

```tsx
// Allows you to define the type later on, creates a placeholder during the definition

// ex. You can create a generic function for making arrays and define the type at runtime

function getArray<T>(items: T[]): T[] {
	return new Array().concat(items); }

// type defined inside function call
const numArray = getArray<number>([1,2,3,4])
const strArray = getArray<string>(['poop', 'butts']) 
```

-REACT

- has a type called ‘FC’ for function component
- 

```tsx
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
```

-INTERFACES

- add a ? at the end of property name to make it optional
- Can pass the interface to a type like this:
- 

```tsx

```