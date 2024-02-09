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


# DECORATOR / WRAPPER
# Good for when you want to add functionality to an object or class that you aren't able to change directly

from abc import ABC, abstractmethod


class CoffeeMachine(ABC):
    @abstractmethod
    def make_small_coffee(self):
        pass

    @abstractmethod
    def make_large_coffee(self):
        pass


class BasicCoffeeMachine(CoffeeMachine):
    def make_small_coffee(self):
        print("Basic coffee machine: Making small coffee")

    def make_large_coffee(self):
        print("Basic coffee machine: Making large coffee")


class EnhancedCoffeeMachine(CoffeeMachine):
    def __init__(self, basic_machine: BasicCoffeeMachine):
        self.basic_machine = basic_machine

    def make_small_coffee(self):
        self.basic_machine.make_small_coffee()

    def make_large_coffee(self):
        print("Enhanced coffee machine: Making large coffee")

    def make_milk_coffee(self):
        print("Enhanced coffee machine: Making milk coffee")
        self.basic_machine.make_small_coffee()
        print("Enhanced coffee machine: adding milk")


if __name__ == '__main__':
    basic_machine = BasicCoffeeMachine()
    enhanced_machine = EnhancedCoffeeMachine(basic_machine)

    enhanced_machine.make_small_coffee()
    print()
    enhanced_machine.make_large_coffee()
    print()
    enhanced_machine.make_milk_coffee()

# BRIDGE
# Good for when you have classes with many orthogonal traits. Converts from inheritance to composition.


from abc import ABC, abstractmethod


class Device(ABC):
    volume = 0

    @abstractmethod
    def get_name(self) -> str:
        pass


class Radio(Device):
    def get_name(self) -> str:
        return f"Radio {self}"


class TV(Device):
    def get_name(self) -> str:
        return f"TV {self}"


class Remote(ABC):
    @abstractmethod
    def volume_up(self):
        pass

    @abstractmethod
    def volume_down(self):
        pass


class BasicRemote(Remote):
    def __init__(self, device: Device):
        self.device = device

    def volume_up(self):
        self.device.volume += 1
        print(f"{self.device.get_name()} volume up: {self.device.volume}")

    def volume_down(self):
        self.device.volume -= 1
        print(f"{self.device.get_name()} volume down: {self.device.volume}")


if __name__ == '__main__':
    radio = Radio()
    tv = TV()

    radio_remote = BasicRemote(radio)
    tv_remote = BasicRemote(tv)

    radio_remote.volume_up()
    radio_remote.volume_down()
    tv_remote.volume_up()
    tv_remote.volume_down()


# COMPOSITE
# Good for when you want to treat multiple objects as one.
# Good for when your core functionality can be represented as a tree.
# Compose objects into tree structures

class Equipment:
    def __init__(self, name: str, price: int):
        self.name = name
        self.price = price


class Composite:
    def __init__(self, name: str):
        self.name = name
        self.items = []

    def add(self, equipment: Equipment):
        self.items.append(equipment)
        return self

    @property
    def price(self):
        return sum([x.price for x in self.items])

if __name__ == '__main__':
    computer = Composite("PC")
    processor = Equipment("Processor", 1000)
    hard_drive = Equipment("Hard drive", 250)
    memory = Composite("Memory")
    rom = Equipment("Read only memory", 100)
    ram = Equipment("Random access memory", 75)

    mem = memory.add(rom).add(ram)
    pc = computer.add(processor).add(hard_drive).add(memory)

    print(pc.price)


# MEMENTO
# store and retrieve history. undo. 

from dataclasses import dataclass

@dataclass
class Memento:
    state: str


class Originator:
    def __init__(self, state):
        self.state = state

    def create_memento(self):
        return Memento(self.state)

    def restore_memento(self, memento: Memento):
        self.state = memento.state


class Caretaker:
    memento_list = []

    def save_state(self, state: Memento):
        self.memento_list.append(state)

    def restore(self, index: int):
        return self.memento_list[index]


if __name__ == '__main__':
    originator = Originator("initial state")
    caretaker = Caretaker()

    caretaker.save_state(originator.create_memento())
    print(f"Current state is {originator.state}")

    originator.state = "state 1"
    caretaker.save_state(originator.create_memento())
    print(f"Current state is {originator.state}")

    originator.state = "state 2"
    caretaker.save_state(originator.create_memento())
    print(f"Current state is {originator.state}")

    originator.restore_memento(caretaker.restore(1))
    print(f"Current state is {originator.state}")

    originator.restore_memento(caretaker.restore(0))
    print(f"Current state is {originator.state}")

    originator.restore_memento(caretaker.restore(2))
    print(f"Current state is {originator.state}")


# STATE
# program can be in a fixed number of states
# state can be encapsulated in an object
# objects behavior changes based on state

from __future__ import annotations
import random
from abc import ABC, abstractmethod


class Game:
    def __init__(self):
        self.state = WelcomeScreenState(self)

    def change_state(self, state):
        self.state = state


class State(ABC):
    def __init__(self, game):
        self.game = game
        print(f"Currently in {self} state")

    @abstractmethod
    def on_welcome_screen(self):
        pass

    @abstractmethod
    def on_playing(self):
        pass

    @abstractmethod
    def on_break(self):
        pass

    @abstractmethod
    def on_end_game(self):
        pass


class WelcomeScreenState(State):
    def on_welcome_screen(self):
        print("Currently on welcome screen")

    def on_playing(self):
        self.game.change_state(PlayingState(self.game))

    def on_break(self):
        print("From welcome to break not allowed")

    def on_end_game(self):
        print("From welcome to end game not allowed")


class PlayingState(State):
    def on_welcome_screen(self):
        print("From playing to welcome not allowed")

    def on_playing(self):
        print("Currently playing")

    def on_break(self):
        self.game.change_state(BreakState(self.game))

    def on_end_game(self):
        self.game.change_state(EndGameState(self.game))


class BreakState(State):
    def on_welcome_screen(self):
        print("From break to welcome not allowed")

    def on_playing(self):
        self.game.change_state(PlayingState(self.game))

    def on_break(self):
        print("Currently on break")

    def on_end_game(self):
        print("From break to end game not allowed")


class EndGameState(State):
    def on_welcome_screen(self):
        self.game.change_state(WelcomeScreenState(self.game))

    def on_playing(self):
        print("From end game to playing not allowed")

    def on_break(self):
        print("From end game to break now allowed")

    def on_end_game(self):
        print("Currently on end game")


if __name__ == '__main__':
    game = Game()

    for i in range(20):
        state = random.randrange(4)
        if state == 0:
            print("Move to welcome")
            game.state.on_welcome_screen()
        elif state == 1:
            print("Move to playing")
            game.state.on_playing()
        elif state == 2:
            print("Move to break")
            game.state.on_break()
        else:
            print("Move to end game")
            game.state.on_end_game()


# TEMPLATE
# Standardizes an algo in a class but allows for flexibility in implementation

from abc import ABC, abstractmethod

class DataStorage(ABC):
    @abstractmethod
    def setup(self):
        pass

    def check_data(self, data):
        print(f"DataStorage: checking data {data}")

    @abstractmethod
    def write_data(self, data):
        pass

    @abstractmethod
    def commit(self):
        pass

    @abstractmethod
    def log(self):
        pass

    def template(self, data):
        self.setup()
        self.check_data(data)
        self.write_data(data)
        self.commit()
        self.log()


class DatabaseDataStorage(DataStorage):
    def setup(self):
        print("Database connection established")

    def write_data(self, data):
        print(f"Database: writing data: {data}")

    def commit(self):
        print("Database: data committed successfully")

    def log(self):
        print("Database: writing completed")


class FileSystemDataStorage(DataStorage):
    def setup(self):
        print("File system ready")

    def write_data(self, data):
        print(f"FileSystem: writing data: {data}")

    def commit(self):
        print("FileSystem: data committed successfully")

    def log(self):
        print("FileSystem: writing completed")


if __name__ == '__main__':
    storage1 = DatabaseDataStorage()
    storage1.template("some data to store")

    print()

    storage2 = FileSystemDataStorage()
    storage2.template("more data")



# VISITOR
# Separate the algorhithm from the objects they operate one. Elements can accept a visitor. Visitor performs actions on the elements.

from __future__ import annotations
from abc import ABC, abstractmethod


class ReportElement(ABC):
    def accept(self, visitor: ReportVisitor):
        visitor.visit(self)


class FixedPriceContract(ReportElement):
    def __init__(self, price_per_year: int):
        self.price_per_year = price_per_year


class TimeAndMaterialsContract(ReportElement):
    def __init__(self, cost_per_hour: int, hours: int):
        self.cost_per_hour = cost_per_hour
        self.hours = hours


class SupportContract(ReportElement):
    def __init__(self, cost_per_month: int):
        self.cost_per_month = cost_per_month


class ReportVisitor(ABC):
    @abstractmethod
    def visit_fpc(self, contract: FixedPriceContract):
        pass

    @abstractmethod
    def visit_tmc(self, contract: TimeAndMaterialsContract):
        pass

    @abstractmethod
    def visit_sc(self, contract: SupportContract):
        pass


class MonthlyCostReportVisitor(ReportVisitor):
    def visit_fpc(self, contract: FixedPriceContract):
        return contract.price_per_year / 12

    def visit_tmc(self, contract: TimeAndMaterialsContract):
        return contract.cost_per_hour * contract.hours

    def visit_sc(self, contract: SupportContract):
        return contract.cost_per_month


class YearlyCostReportVisitor(ReportVisitor):
    def visit_fpc(self, contract: FixedPriceContract):
        return contract.price_per_year

    def visit_tmc(self, contract: TimeAndMaterialsContract):
        return contract.cost_per_hour * contract.hours

    def visit_sc(self, contract: SupportContract):
        return contract.cost_per_month * 12


if __name__ == '__main__':
    project_alpha = FixedPriceContract(10000)
    project_beta = TimeAndMaterialsContract(150, 10)
    project_gamma = SupportContract(500)

    monthly_visitor = MonthlyCostReportVisitor()
    monthly_cost = monthly_visitor.visit_fpc(project_alpha)
    monthly_cost += monthly_visitor.visit_tmc(project_beta)
    monthly_cost += monthly_visitor.visit_sc(project_gamma)
    print(f"Monthly cost is: {monthly_cost}")

    yearly_visitor = YearlyCostReportVisitor()
    yearly_cost = yearly_visitor.visit_fpc(project_alpha)
    yearly_cost += yearly_visitor.visit_tmc(project_beta)
    yearly_cost += yearly_visitor.visit_sc(project_gamma)
    print(f"Yearly cost is: {yearly_cost}")

