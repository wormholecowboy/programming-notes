
MISC
• String literal: f'Some thing and {anotherVarThing}!' (use commas if not using literal)
• Recursive functions need a base case to make sure it stops, written with if statement
• Lamda fn: anonymous function
# (is vs. ==) is checks if two variables refer to the same object, but == checks
# if the objects pointed to have the same values.
- Don't use the equality "==" symbol to compare objects to None
      Use "is" instead. This checks for equality of object identity.

# if can be used as an expression
# Equivalent of C's '?:' ternary operator
"yay!" if 0 > 1 else "nay!"  # => "nay!"

same as the js spread operator
li2 = li[:] 

easy swapping
a,b = b,a


SORT JSON DICT OR LIST by inner keys
sorted( dictName, key = lambda col: col[ 'keyYouWant'] )

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


DATA STRUCTURES (lists, tuples, dicts, sets)
Tuples are more memory efficient than lists
Tuples have a slightly higher time efficiency than lists
• Tuples are capable of holding one item as long as the item is followed by a comma
• Dicts: keys must be an immutable data type such as strings, numbers or tuples.
• .update fn is good for updating and adding at the same time for dicts
• A set is unordered and has only uniques (good way to de-dupe a list)
• Queue: FIFO
• Stack: LIFO


OOP
• constructor:   def __init__(self)
• destructor: __del__()
• Protected access modifiers, denoted with the prefix _, prevent members from being accessed outside of the class, unless it’s from a subclass.
• Private access modifiers, denoted with the prefix __, declare members to be accessible within the class only. 
• The child class must contain the following:
Name of the parent class in the definition of the child class
Constructor of the parent class called within the constructor of the child class
• Polymorphism in OOP is the concept of classes sharing methods with the same name.

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

FILES

```python
#opening files


os.path.join(folder, anotherFolder)
os.getcwd()
os.chdir(dir)
os.path.abspath(relativePath)
os.unlink(file)  # delete a file
os.rmdir(dir)  # folder must be empty
shutil.rmtree(dir)  # deletes a full folder
send2trach.send2trach(path)  # safer delete

os.walk(path)  # walks a tree, useful in a loop
for folder, subfolder, file in os.walk(path)

with open('filename.txt') as whatever_variable:
		contents = whatever_variable.read()
whatever_variable.close()


def writeFile(self, filepathname, texttoinsert)
		with open(filepathname, 'w') as fileobj:
				fileobj.write(texttoinsert)

# 'w' tells the open function that you want to write
# 'a' is to append to the file
# 'wb' is write binary (useful for when writing using text from the web)
# or you can specify the encoding
        with open(file, 'w', encoding='utf-8')


import shelve  #stores non-text data to a file for later use
# works like a dict for accessing
# persists objects for later use
shelve.open('filename')
shelve.close()


import shutil
shutil.copy(filepath, filedestination)
shutil.copytree(foldertocopy, destination)
shutil.move(file, dest)


```

LIST COMPREHENSION: Create a list based on a previous list (can be filtered)

create a new list based off another with one line of code
newlist = [x for x in fruits if "a" in x]
only adds x based on your condition
alternative would be to use map()
list(map( lambda x: if "a" in x, fruits ) )

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


CONTROL FLOW
• pass: do nothing
• break: stops loop. similar to return in JS
• continue: skip to next iteration


JSON
import json
with loading, usually JSON docs -> dicts and JSON arrarys -> lists
json.load() converts a JSON file to a dict (takes a filepath)
json.loads() converts a JSON string to a dict (takes a string)
   note: you must open() the file first. both take file object.


# IMPORTS / MODULES
## absolute
Let’s assume the following:

package1/module2.py contains a function, function1.
package2/__init__.py contains a class, class1.
package2/subpackage1/module5.py contains a function, function2.
The following are practical examples of absolute imports:

from package1 import module1
from package1.module2 import function1
from package2 import class1
from package2.subpackage1.module5 import function2

## relative
from .some_module import some_class
from ..some_package import some_function
from . import some_class


# REGEX
import re

create regex objects with this method + raw strings
searchPattern = re.compile(r'.*')
searchPattern = re.compile(r'.*', re.I)  // ignore case
searchPattern = re.compile(r'.*', re.DOTALL)  // .* even grabs new lines
combine args with pipe
 
mo = searchPattern.search(string)  // only finds first instance
mo = searchPattern.findall(string)
mo = searchPattern.sub(stringToSubIn, text)  // you can use groups in the sub string too

these return a match object with its own methods
mo.group()  // displays mo

VERBOSE mode doesn't count white spaces, nicer formatting
regex = re.compile(r'''
\d\d\d 
.*       #random comment
\w''', re.VERBOSE) 


# DEBUGGING
try and except
raise Exception('error message')
assert condition, 'message if not true'
    this is usefule for debugging
use traceback module to log to a file
OR
import logging
logging.BasicConfig(filename="file.txt", level=loggig.DEBUG, format="%(asctime)s - %(levelname)s - %(message)s")
logging.debug("message you want in your program")
logging.disable(logging.CRITICAL)   temp suspend logging


# VENV VIRTUAL ENVIRONMENTS
## create
python3 -m venv <directory_name>  // convention to name it .venv

## activate
. .venv/bin/activate
deactivate

## install
python -m pip install <package-name>
### Note: Because you’ve created your virtual environment using a version of Python 3, you don’t need to call python3 or pip3 explicitly. As long as your virtual environment is active, python and pip link to the same executable files that python3 and pip3 do.

## create requirements file
pip freeze > requirements.txt

## install from requirements
pip install -r requirements.txt
