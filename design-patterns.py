#  BUILDER
#  Problem: when constuction is getting too complicated, constructor has 10+ args
#  Solution: Build an API to build the object in pieces, extract the object construction code out of its own class and move it to separate class called builder.


class NetworkService:
    def __init__(self):
        self.components = {}

    def add(self, key, value):
        self.components[key] = value


class NetworkServiceBuilder:
    def __init__(self):
        self._service = NetworkService()

    def add_url(self, url):
        self._service.add("url", url)

    def add_cache(self, cache):
        self._service.add("cache", cache)

    def add_auth(self, auth):
        self._service.add("auth", auth)

    def build(self):
        service = self._service
        self._service = NetworkService()  # reset the builder for the next build
        return service


builder = NetworkServiceBuilder()
builder.add_url("poop.com")
builder.add_auth(123409873847)
service1 = builder.build()  # builder gets reset here for the next one

builder.add_cache("cache_things")
service2 = builder.build()

# OR you can return 'self' from each method and then chain them like js
builder2 = NetworkService().add_url().add_auth()


# SINGLETON
## Instanctiate once. Good for a global state
# type is the default metaclass for all classes in Python.
# Metaclasses are responsible for defining how classes themselves are created. When you define a class in Python, the metaclass is responsible for creating that class.
# By default, if you don't explicitly specify a metaclass, Python uses type as the metaclass.

from threading import Lock


class Singleton(type):
    _instances = {}
    _lock = Lock()  # for multi threading safety

    def __call__(self, *args, **kwargs):
        with self._lock:
            if self not in self._instances:
                instance = super().__call__(*args, **kwargs)
                self._instances[self] = instance
        return self._instances[self]


class NetworkProvider(metaclass=Singleton):
    def log(self):
        print(f"{self}")


# FACTORY
# good for when requirements are prone to change
# interface of abstract class => interface implementation => factory class for instantiating
# The Factory Method pattern suggests that you replace direct object construction calls (using the new operator) with calls to a special factory method.
# Don’t worry: the objects are still created via the new operator, but it’s being called from within the factory method.
# pros: The factory pattern is useful when we have to create multiple smaller objects that share the same properties.
# cons:

from abc import (
    ABC,
    abstractmethod,
)  # Python does not have interfaces, uses abstract base classes instead


class Country:
    pass


class Japan(Country):
    pass


class USA(Country):
    pass


class CurrencyFactory(ABC):
    @abstractmethod
    def currency_factory(self, country) -> str:
        pass


class FiatCurrencyFactory(CurrencyFactory):
    def currency_factory(self, country) -> str:
        if country is USA:
            return "USD"
        elif country is Japan:
            return "JPY"
        else:
            return "EUR"


# ABSTRACT FACTORY
#  Factory that produces product families/factories. There can also be products for each family that follow an interface.

from abc import ABC, abstractmethod


# Abstract Product Interface
class Button(ABC):
    @abstractmethod
    def render(self):
        pass


# Concrete Product
class LightButton(Button):
    def render(self):
        return "Light Button"


# Concrete Product
class DarkButton(Button):
    def render(self):
        return "Dark Button"


# Abstract Product Interface
class Checkbox(ABC):
    @abstractmethod
    def render(self):
        pass


# Concrete Product
class LightCheckbox(Checkbox):
    def render(self):
        return "Light Checkbox"


# Concrete Product
class DarkCheckbox(Checkbox):
    def render(self):
        return "Dark Checkbox"


# Abstract Factory Interface
class ThemeFactory(ABC):
    @abstractmethod
    def create_button(self) -> Button:
        pass

    @abstractmethod
    def create_checkbox(self) -> Checkbox:
        pass


# Concrete Factory
class LightThemeFactory(ThemeFactory):
    def create_button(self) -> Button:
        return LightButton()

    def create_checkbox(self) -> Checkbox:
        return LightCheckbox()


# Concrete Factory
class DarkThemeFactory(ThemeFactory):
    def create_button(self) -> Button:
        return DarkButton()

    def create_checkbox(self) -> Checkbox:
        return DarkCheckbox()


# Client Code
def apply_theme(factory: ThemeFactory):
    button = factory.create_button()
    checkbox = factory.create_checkbox()

    print(f"Rendering {button.render()} and {checkbox.render()}")


# Example Usage
light_theme_factory = LightThemeFactory()
dark_theme_factory = DarkThemeFactory()

apply_theme(light_theme_factory)
apply_theme(dark_theme_factory)


# PROTOTYPE
# When you need a copy of a complex object without worry about coupling, private fields, etc.
# Share properties with a new object by sharing through the prototype chain.
# Useful in testing and pre-prod

import copy


# Prototype class
class Prototype:
    def clone(self):
        pass


# Concrete Prototype
class ConcretePrototype(Prototype):
    def __init__(self, name):
        self.name = name

    def clone(self):
        # Using deepcopy to create a deep copy of the object
        return copy.deepcopy(self)


# Client code
def main():
    # Creating an instance of ConcretePrototype
    original_prototype = ConcretePrototype("Original Prototype")

    # Cloning the original prototype
    cloned_prototype = original_prototype.clone()

    # Modifying the cloned prototype
    cloned_prototype.name = "Cloned Prototype"

    # Displaying the names of both prototypes
    print(f"Original Prototype: {original_prototype.name}")
    print(f"Cloned Prototype: {cloned_prototype.name}")


if __name__ == "__main__":
    main()


# ADAPTER
# converts the interface of a class into an interface that the client expects
# wraps the 3rd party interface while implementing the expected client interface

# Existing class with a different interface
class RectangleCalculator:
    def calculate_area(self, width, height):
        return width * height

# Target interface expected by the client
class Shape:
    def calculate_area(self):
        pass

# Adapter class that adapts RectangleCalculator to the Shape interface
class RectangleAdapter(Shape):
    def __init__(self, rectangle_calculator, width, height):
        self.rectangle_calculator = rectangle_calculator
        self.width = width
        self.height = height

    def calculate_area(self):
        return self.rectangle_calculator.calculate_area(self.width, self.height)

# Client code expecting objects with the Shape interface
def calculate_total_area(shapes):
    total_area = 0
    for shape in shapes:
        total_area += shape.calculate_area()
    return total_area

# Example usage
rectangle_calculator = RectangleCalculator()
rectangle_adapter = RectangleAdapter(rectangle_calculator, width=5, height=10)

total_area = calculate_total_area([rectangle_adapter])
print(f"Total Area: {total_area}")

# In this example:
# 
# RectangleCalculator is the existing class with a method to calculate the area of a rectangle.
# Shape is the target interface expected by the client, which has a calculate_area method.
# RectangleAdapter is the adapter class that wraps an instance of RectangleCalculator and implements the Shape interface.
# It adapts the interface of RectangleCalculator to match the Shape interface.
# Now, the client code can work with objects that adhere to the Shape interface, even though the original RectangleCalculator class had a different interface.
# The adapter acts as a bridge between the existing class and the expected interface, allowing them to work together seamlessly.




# STRATEGY 
# when you have multiple ways to handle data, views, etc.
# class or algo can be changed at runtime depending on requirements
# objects contain the logic and the executor/context handles the algo objects

class Printer:
    def __init__(self, print_strategy):
        self.print_strategy = print_strategy
    def print(self, msg: str):
        print(self.print_strategy(msg))

def lower(msg: str):
    return msg.lower()

def upper(msg: str):
    return msg.upper()

some_string = "blah BLAH"

lower_printer = Printer(lower)
lower_printer.print(some_string)










