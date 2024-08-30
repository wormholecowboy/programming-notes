// SINGLE RESPONSIBILITY
// classes and functions should have one responsibility. They should only have one reason to change.

// OPEN-CLOSED PRINCIPLE
//
/* - Classes, functions, etc. should be open to extension, closed to modification
    - Don't modify classes. Extend them with inheritance or composition.  
    - State space explosion: requirements cause exponential need for method for every permutation
    - If you have a ton of ‘if’ statements or a case, you are likely violating this principle
    So, for example, you would just pass a ‘new SomeClass’ variable or array of classes into the function as an argument. */

// specification is the filter
// combinator combines the filters
let products = [one, two, three];

class Filter {
  filter(items, spec) {
    return items.filter((x) => spec.isSatisfied(x));
  }
}

class ColorSpec {
  constructor(color) {
    this.color = color;
  }
  isSatisfied(item) {
    return this.color === item.color;
  }
}

class SizeSpec {
  constructor(size) {
    this.size = size;
  }
  isSatisfied(item) {
    return this.size === item.size;
  }
}

class Combinator {
  constructor(...specs) {
    this.specs = specs;
  }
  isSatisfied(item) {
    return this.specs.every((x) => x.isSatisfied(item));
  }
}

let f = new Filter();

// return names of products that are green
let search1 = f.filter(products, new ColorSpec("green"));
for (let p of search1) {
  return p.name;
}

// return names of prods that are green and large
let spec = new Combinator(new ColorSpec("green"), new SizeSpec("large"));
let search2 = f.filter(products, spec);
for (let p of search2) {
  return p.name;
}

// LISKOV SUBSTITUTION PRINCIPLE

/* - You should be able to substitute a base type for a subtype    
    * - If S is a subtype of T, then objects of type T may be replaced with objects of type S
        - A dog class should be able to be swapped in for an animal class without any issues
    - ex. a duck and penguin inheriting a bird super class would fail, because a penguin cannot fly and would fail the basic requirements of the bird class.
        - all sub classes can properly call their parent methods
    - tends to be a problem with inheritance, use composition instead */

// INTERFACE SEGREGATION PRINCIPLE

// - If you have a class implementing an interface, it should use every portion of that interface. Otherwise, you need to break out your interfaces into smaller ones.
// - Don't make people implement more than they need to


// MIXIN
// extra function you will add dynamically
let extraFunctionality = {
  doSomething() {
    // whatever
  },
};

// define class
class MyClass {
  constructor(name) {
    this.name = name;
  }
}

// add the functionality to the class
Object.assign(MyClass.prototype, extraFunctionality);

// instantiate
const whatever = new MyClass(blah);

// run method
whatever.doSomething();


// DEPENDENCY INVERSION

/*  High level modules should not depend on low level ones. Use abstractions.
    - Your code depends on a created wrapper api which talks to your external dependency, rather than having the dependencies api code directly in your main app code.
    - Tends to use the facade or adapter pattern
    - You’ll end up passing the external dependency as an new class argument to the main app, which will then be connected to your wrapper api inside the app.
    */

// BUILDER
// get rid of long parameter lists in fns

// traditional way
//
class User {
  constructor(name) {
    this.name = name;
  }
}

class UserBuilder {
  constructor(name) {
    this.user = new User(name);
  }

  setAge(age) {
    this.user.age = age;
    return this;
  }

  setNumber(number) {
    this.user.number = number;
    return this;
  }

  setAddress(address) {
    this.user.address = address;
    return this;
  }

  build() {
    return this.user;
  }
}

let user = new UserBuilder("bob").setAge(10).setNumber("5555703829").build();

// newer js way
//

class User {
  constructor(name, { age, address, number } = {}) {
    this.name = name;
    this.age = age;
    this.address = address;
    this.number = number;
  }
}

let user2 = new User("Bob", { age: 10, number: 5555703829 });



// SINGLETON
//
class GlobalState {
  constructor() {
    if (GlobalState.intance == null) {
      GlobalState.instance = this;
    }
    return GlobalState.instance;
  }
}

const state = new GlobalState();
Object.freeze(state);
// export the instance, not the class



// PROTOTYPE

let obj;
let obj2 = Object.create(obj);

// access prototype of object
Object.getPrototypeOf(obj2); // obj
// note: classes' prototype refers to the constructor



// NULL OBJECT
// Reduces the need for null checks. Return a null object from your fns instead of returning null. Null object properties should match expected object.

class NullUser {
  constructor() {
    this.name = "Guest";
    this.id = -1;
  }

  hasAccess() {
    return false;
  }
}

function getUser(id) {
  const user = users.find((user) => user.id == id);
  if (user == null) {
    return new NullUser();
  } else {
    return user;
  }
}

function printUser(id) {
  const user = getUser(id);
  console.log(user);
} // no need for null checks here.



// FACADE
// hides ugly code in its own fn or module
// provides a clean interface for client

function getUsers() {
  return getFetch(myUrl, myParams);
}

function getFetch(url, params) {
  const query = Object.entries(
    params
      .map((param) => {
        return `${param[0]}=${param[1]}`;
      })
      .join("&"),
  );
  return fetch(url, {
    method: "GET",
    headers: {},
  }).then((res) => res.json());
}


// COMMAND
// request is wrapped in an object that contains all request info
// separate fns out into their own class to hand command logic, undo fns, etc.
// Gives the command caller a generalized "execute" fn

class OrderManager {
  constructor() {
    this.orders = [];
  }

  execute(command, ...args) {
    return command.execute(this.orders, ...args);
  }
}

class Command {
  constructor(execute) {
    this.execute = execute;
  }
}

function PlaceOrderCommand(order, id) {
  return new Command((orders) => {
    orders.push(id);
    return `You have successfully ordered ${order} (${id})`;
  });
}

function CancelOrderCommand(id) {
  return new Command((orders) => {
    orders = orders.filter((order) => order.id !== id);
    return `You have canceled your order ${id}`;
  });
}

function TrackOrderCommand(id) {
  return new Command(() => `Your order ${id} will arrive in 20 minutes.`);
}

const manager = new OrderManager();

manager.execute(new PlaceOrderCommand("Pad Thai", "1234"));
manager.execute(new TrackOrderCommand("1234"));
manager.execute(new CancelOrderCommand("1234"));



// PROXY
// interact with an object through an intermediary 
// useful when a large object is expensive to duplicate
// provides additional functionality before or after object
// same interface
// manages lifecycle of object
// can be used for validation too

const person = {
  name: "John Doe",
  age: 42,
  nationality: "American"
};

const personProxy = new Proxy(person, {
  get: (obj, prop) => {
    console.log(`The value of ${prop} is ${obj[prop]}`);
  },
  set: (obj, prop, value) => {
    console.log(`Changed ${prop} from ${obj[prop]} to ${value}`);
    obj[prop] = value;
    return true;
  }
});

personProxy.name;  // The value of name is John Doe
personProxy.age = 43;  // Changed age from 42 to 43


// OBSERVER

class Observable {
  constructor() {
    this.observers = [];
  }

  subscribe(func) {
    this.observers.push(func);
  }

  unsubscribe(func) {
    this.observers = this.observers.filter((observer) => observer !== func);
  }

  notify(data) {
    this.observers.forEach((observer) => observer(data));
  }
}

function logger(data) {
  console.log(`${Date.now()} ${data}`);
}

function toastify(data) {
  toast(data);
}

// fns themselvves get logged so we can call their methods inside the publisher
observable.subscribe(logger);
observable.subscribe(toastify);

export default function App() {
  function handleClick() {
    observable.notify("User clicked button!");
  }

  function handleToggle() {
    observable.notify("User toggled switch!");
  }

  return (
    <div className="App">
      <Button>Click me!</Button>
      <FormControlLabel control={<Switch />} />
      <ToastContainer />
    </div>
  );
}


// MEDIATOR - MIDDLEWARE
// provides a central object for communicating between objects

class ChatRoom {
  logMessage(user, message) {
    const sender = user.getName();
    console.log(`${new Date().toLocaleString()} [${sender}]: ${message}`);
  }
}

class User {
  constructor(name, chatroom) {
    this.name = name;
    this.chatroom = chatroom;
  }

  getName() {
    return this.name;
  }

  send(message) {
    this.chatroom.logMessage(this, message);
  }
}

const chatroom = new ChatRoom();

const user1 = new User("John Doe", chatroom);
const user3 = new User("Jane Doe", chatroom);

user1.send("Hi there!");
user2.send("Hey!");


// FLYWEIGHT
// reduce the memory or computing load
// good when you have a large number of objects

class Book {
  constructor(title, author, isbn) {
    this.title = title;
    this.author = author;
    this.isbn = isbn;
  }
}

const isbnNumbers = new Set();
const bookList = [];

const addBook = (title, author, isbn, availability, sales) => {
  const book = {
    ...createBook(title, author, isbn),
    sales,
    availability,
    isbn
  };

  bookList.push(book);
  return book;
};

const createBook = (title, author, isbn) => {
  const exists = isbnNumbers.has(isbn);
  if (exists) {
    const book = bookList.filter(book => book.isbn === isbn)
    return book;
  } else {
    const book = new Book(title, author, isbn);
    isbnNumbers.add(isbn);
    return book;
  }
};

addBook("Harry Potter", "JK Rowling", "AB123", false, 100);
addBook("Harry Potter", "JK Rowling", "AB123", true, 50);
addBook("To Kill a Mockingbird", "Harper Lee", "CD345", true, 10);
addBook("To Kill a Mockingbird", "Harper Lee", "CD345", false, 20);
addBook("The Great Gatsby", "F. Scott Fitzgerald", "EF567", false, 20);

console.log("Total amount of copies: ", bookList.length);
console.log("Total amount of books: ", isbnNumbers.size);

class Book {
  constructor(title, author, isbn) {
    this.title = title;
    this.author = author;
    this.isbn = isbn;
  }
}

const isbnNumbers = new Set();
const bookList = [];

const addBook = (title, author, isbn, availibility, sales) => {
  const book = {
    ...createBook(title, author, isbn),
    sales,
    availibility,
    isbn
  };

  bookList.push(book);
  return book;
};

const createBook = (title, author, isbn) => {
  const book = isbnNumbers.has(isbn);
  if (book) {
    return book;
  } else {
    const book = new Book(title, author, isbn);
    isbnNumbers.add(isbn);
    return book;
  }
};

addBook("Harry Potter", "JK Rowling", "AB123", false, 100);
addBook("Harry Potter", "JK Rowling", "AB123", true, 50);
addBook("To Kill a Mockingbird", "Harper Lee", "CD345", true, 10);
addBook("To Kill a Mockingbird", "Harper Lee", "CD345", false, 20);
addBook("The Great Gatsby", "F. Scott Fitzgerald", "EF567", false, 20);

console.log("Total amount of copies: ", bookList.length);
console.log("Total amount of books: ", isbnNumbers.size);class Book {
  constructor(title, author, isbn) {
    this.title = title;
    this.author = author;
    this.isbn = isbn;
  }
}

const isbnNumbers = new Set();
const bookList = [];

const addBook = (title, author, isbn, availibility, sales) => {
  const book = {
    ...createBook(title, author, isbn),
    sales,
    availibility,
    isbn
  };

  bookList.push(book);
  return book;
};

const createBook = (title, author, isbn) => {
  const book = isbnNumbers.has(isbn);
  if (book) {
    return book;
  } else {
    const book = new Book(title, author, isbn);
    isbnNumbers.add(isbn);
    return book;
  }
};

addBook("Harry Potter", "JK Rowling", "AB123", false, 100);
addBook("Harry Potter", "JK Rowling", "AB123", true, 50);
addBook("To Kill a Mockingbird", "Harper Lee", "CD345", true, 10);
addBook("To Kill a Mockingbird", "Harper Lee", "CD345", false, 20);
addBook("The Great Gatsby", "F. Scott Fitzgerald", "EF567", false, 20);

console.log("Total amount of copies: ", bookList.length);
console.log("Total amount of books: ", isbnNumbers.size);


// DECORATOR
// wraps an unchangable object or class and adds fucntionality

// Base class interface
class Coffee {
  getCost() {
    return 5; // Base cost of a coffee
  }

  getDescription() {
    return "Coffee"; // Base description
  }
}

// Decorator class
class CoffeeDecorator extends Coffee {
  constructor(coffee) {
    super();
    this.coffee = coffee;
  }

  getCost() {
    return this.coffee.getCost(); // Delegate cost calculation to the wrapped object
  }

  getDescription() {
    return this.coffee.getDescription(); // Delegate description to the wrapped object
  }
}

// Concrete decorator class
class MilkDecorator extends CoffeeDecorator {
  constructor(coffee) {
    super(coffee);
  }

  getCost() {
    return super.getCost() + 1; // Add cost of milk
  }

  getDescription() {
    return super.getDescription() + ", with Milk"; // Add milk description
  }
}

// Usage
const myCoffee = new Coffee();
console.log("Cost: $" + myCoffee.getCost()); // Output: Cost: $5
console.log("Description: " + myCoffee.getDescription()); // Output: Description: Coffee

const coffeeWithMilk = new MilkDecorator(myCoffee);
console.log("Cost: $" + coffeeWithMilk.getCost()); // Output: Cost: $6
console.log("Description: " + coffeeWithMilk.getDescription()); // Output: Description: Coffee, with Milk



















