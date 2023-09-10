# Head First Design Patterns

Created: October 19, 2021 11:03 PM
Updated: February 17, 2022 8:47 AM

Principle 1: Encapsulate what varies

Principle 2: Favor composition over inheritance

Principle 3: Program to interfaces, not implementations

Principle 4: Strive for loosely coupled designs between objects that interact

- Identify the aspects of your application that vary and separate them from what stays the same

# 2) Observer

- Subject broadcasts to observers when it receives new data
- one-to-many relationship
- observers can also become broadcasters to their own subscribers
- You can push and pull data (pull is more correct)