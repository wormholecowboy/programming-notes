# Introduce Parameter Object

![Untitled](Introduce%20Parameter%20Object%20e9b864e6be9b457aa4c6f6a793b82f99/Untitled.png)

You basically pass the object name as param, then call object.member inside the function. 

HOW

1. Create a new class that will represent your group of parameters. Make the class immutable.
2. In the method that you want to refactor, use **[Add Parameter](https://refactoring.guru/add-parameter)**, which is where your parameter object will be passed. In all method calls, pass the object created from old method parameters to this parameter.
3. Now start deleting old parameters from the method one by one, replacing them in the code with fields of the parameter object. Test the program after each parameter replacement.
4. When done, see whether there’s any point in moving a part of the method (or sometimes even the whole method) to a parameter object class. If so, use **[Move Method](https://refactoring.guru/move-method)** or **[Extract Method](https://refactoring.guru/extract-method)**.