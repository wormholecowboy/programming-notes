# Coding Principles

Created: August 31, 2021 6:11 PM
Updated: May 28, 2022 3:45 PM

<aside>
💡 principles

</aside>

- when you get working code, break it!
- use proper nesting to keep things clean
- comment on your closing tags to make code easier to read
- code should be self-describing
- Reuse other peoples code. Dont reinvent wheel.
- Avoid mutated or shared state
- Use composition over inheritance
- google your bugs
- most complexity is simple things layered

<aside>
⚓ OOP

</aside>

Principle 1: Encapsulate what varies

Principle 2: Favor composition over inheritance

Principle 3: Program to interfaces, not implementations

- getter and setter functions should match their property names
- best practice to create separate php pages that only contain your classes
- Interfaces provide method signatures without implementing them. Classes that adopt these interfaces are required to implement them.
    - Mixins are similar to interfaces except that they implement the methods themselves.
- Composition vs. Inheritance
    - Composition: Has-a
    - Inheritance: Is-a
- Don't directly access properties. Use getter methods instead??
- Objects = nouns, methods = verbs

<aside>
💡 Misc

</aside>

- Use guard clauses instead of nested logic

..

String & Number Manipulation
• Use "% 10" to grab the last digit of a number
• Use Int division to chop off the last digit of a number

