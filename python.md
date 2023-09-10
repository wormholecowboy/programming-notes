# OP: Python

Created: January 27, 2022 6:14 PM
Updated: May 14, 2022 11:29 AM

len —-length

del ——delete

3 Sequence types

- List: uses square
  - ex. list = [value, value]
  - list is the same as an array
  - list.append()
  - list.reverse() —-reverses the order of the array
  - list.count() —- counts the num of args in the function
- Tuples: Cannot be edited! Uses Parenthesis
  - myTuple = (value, value)
- Dictionaries (dict, map) —-uses curly braces like and obj in js
  - ex. {name:value, name:value}
  - access it: dict["name"]
  - adding: cart["added key"] = value
  - delete: del dict['item to remove']

Functions

def functionName():
function body

''''
This is a
multi-line
text string

also called docstring

use for multi-line strings
'''

pass keyword: tells python to ignore function for now (no code yet)

self is same as 'this' in js
must include it in parameters

INCREMENTING:

```python
count += 1
```

classes

```python
def class Car():
	def __init__(arg, arg2, arg3) OPTIONAL
		self.arg = bla bla bla
		self.arg2 = bla bla

#instantiate
myCar = Car()

#must include self in methods

```

print out docstrings in class: print(class.**doc**)

Inheritance

- Pass one class as an arg to another
- New class will inherit arg class

Python special methods are called with double underscores surrounded

None = Null in Python

```python
#creating a default arg

def __init__(self, arg=None)
```

OPEN FILES

```python
#opening files

with open('filename.txt') as whatever_variable:
		contents = whatever_variable.read()
```

ERROR HANDLING

```python
#keyords: try & except

				try:
          #function body

        except {errormessage}:
            # What to do in case of error
        else:
            # What to do in case of success
```

WRITE A FILE

```python
def writeFile(self, filepathname, texttoinsert)
		with open(filepathname, 'w') as fileobj:
				fileobj.write(texttoinsert)

# 'w' tells the open function that you want to write

# 'a' is to append to the file
```

LIST COMPREHENSION: Create a list based on a previous list (can be filtered)

```python
newlist = [expression for item in iterable if condition == True]

fruits = ["apple", "banana", "cherry", "kiwi", "mango"]

newlist = [x for x in fruits if "a" in x]

IS THE SAME AS...

fruits = ["apple", "banana", "cherry", "kiwi", "mango"]
newlist = []

for x in fruits:
  if "a" in x:
    newlist.append(x)

print(newlist)
```
