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
        return this.specs.every(x => x.isSatisfied(item))
    }
}

let f = new Filter();

// return names of products that are green
let search1 = f.filter(products, new ColorSpec("green"));
for (let p of search1) {
  return p.name;
}

// return names of prods that are green and large
let spec = new Combinator(new ColorSpec("green"), new SizeSpec("large"))
let search2 = f.filter(products, spec)
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

// extra function you will add dynamically
let extraFunctionality = {
    doSomething() {
        // whatever
    }
}

// define class
class MyClass {
    constructor(name) {
        this.name=name;	
    }
}

// add the functionality to the class
Object.assign(MyClass.prototype, extraFunctionality);

// instantiate
const whatever = new MyClass(blah)

// run method
whatever.doSomething();



// DEPENDENCY INVERSION

    /*  High level modules should not depend on low level ones. Use abstractions.
    - Your code depends on a created wrapper api which talks to your external dependency, rather than having the dependencies api code directly in your main app code.
    - Tends to use the facade or adapter pattern
    - You’ll end up passing the external dependency as an new class argument to the main app, which will then be connected to your wrapper api inside the app.
    */




























