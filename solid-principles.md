# SOLID Principles+

Created: May 21, 2022 5:28 PM
Updated: June 25, 2022 9:22 AM

- SOLID
    
    SINGLE-RESPONSIBILITY PRINCIPLE
    
    - all classes functions, classes, modules should only have one responsibility
        - it should only ever have ONE reason to change
        - ex. if your class has more 2 methods that change for different reasons, you would pull a method out and put it in its own module and export it
        
    
    OPEN-CLOSED PRINCIPLE
    
    - Classes, functions, etc. should be open to extension, closed to modification
    - If you have a ton of ‘if’ statements or a case, you are likely violating this principle
    - Instead of having everything hard-coded in one function, split out various cases into their own classes which have the execution logic inside them. Then just call their class method inside of your main function, ergo, the main function doesn’t need to know the details of implementation. 
    
    So, for example, you would just pass a ‘new SomeClass’ variable or array of classes into the function as an argument.
    
    LISKOV SUBSTITUTION PRINCIPLE
    
    - If S is a subtype of T, then objects of type T may be replaced with objects of type S
        - A dog class should be able to be swapped in for an animal class without any issues
    - ex. a duck and penguin inheriting a bird super class would fail, because a penguin cannot fly and would fail the basic requirements of the bird class.
        - all sub classes can properly call their parent methods
    - tends to be a problem with inheritance, use composition instead
    
    INTERFACE SEGREGATION PRINCIPLE
    
    - If you have a class implementing an interface, it should use every portion of that interface. Otherwise, you need to break out your interfaces into smaller ones.
    
    ```jsx
    
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
    ```
    
    DEPENDENCY INVERSION PRINCIPLE
    
    - Your code depends on a created wrapper api which talks to your external dependency, rather than having the dependencies api code directly in your main app code.
    - Tends to use the facade or adapter pattern
    - You’ll end up passing the external dependency as an new class argument to the main app, which will then be connected to your wrapper api inside the app.

MISC

- avoid commenting, make code self explanatory
- avoid double negatives (!notAdmin), create only positive variables
- make var types obvious(use ‘is’ in front of bools: isAdmin)
- avoid magic numbers
- 3 args max for functions, if you need more, make a class
- put long conditions in a var
- use guard clauses: return right after logic checks
- write with psuedo-code first to firgure out your logic
- Avoid returning different types from the same function
- Check for:
    - Always plan for null or undefined (bad inputs)
    - remember 0 and empty strings eval to false, can screw up your logic
    - don’t forget defaults for parameters, in case they are not used, make them empty
        - use destructuring in params to pass in CONST defaults
- Favor CONST variables over intermediate variables that continually get updated through program
- Avoid using else.  Use guard clauses, even pulling complex nesting out into its own function with multiple returns
- Avoid (!user), it can create implicit type cohersion. check for null or NaN instead. Only use if you know the var is already a bool.