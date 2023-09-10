# Replace Temp Variable with Query

PROBLEM: expression inside a local variable

SOLUTION: move the expression out into a method and return the result. Query the method instead of using a variable. 

HOW: 

Make sure variable is assigned only once in method(split if necessary)

If the method changes object state, use Separate Query From Modifier