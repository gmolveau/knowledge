> from pluralsight

modules are singleton

# Closures and decorators

closure maintains references to objects from earlier scopes

```python
def raise_to(exp):
    def raise_to_exp(x):
        return pow(x, exp)
    return raise_to_exp

square = raise_to(2) # square is now a function
assert square(2) == 4
cube = raise_to(3)
assert cube(3) == 9
```

lambdas are one-line function without a name

```python
length = lambda name: len(name)
assert length("oui") == 3
```

```python
def function(a, b):
    print("A function")

    def local_function(x, y):
        print("A local function")
        return x*y + a*b
    return local_function
```

lambdas // TODO
function factories
decorators

```python
def logging_decorator(f):
    @functools.wraps(f) #forwards __doc__ and __name__
    def logging_wrapper():
        print(f"{f.__name__} function was called")
        return f
    return logging_wrapper

#@second_decorator - decorators are called in reverse-order
@logging_decorator
def hello():
    '''print hello'''
    print("Hello")

hello()
```

wrappers


# properties and class methods
class_attribute
instance_attribute

```python
class Foo:

    a_class_attribute = 0

    def __init__(self):
        self.an_instance_attribute = 42
        Foo.a_class_attribute = 64
        self.a_class_attribute = "actually doesnt change the class attribute"

    @staticmethod
    def a_static_method():
        return "No self, can't use the class attributes"

    @classmethod
    def a_class_method(cls):
        cls.a_class_attribute += 1

    @classmethod
    def a_named_constructor(cls):
        return cls()

    def _get_a_property(self):
        return self.an_instance_attribute

    @property
    def a_property(self):
        self._get_a_property()

    def _set_a_property(self, value):
        self.an_instance_attribute = value

    @a_property.setter
    def a_property(self, value):
        self._set_a_property(value)
    
class Bar(Foo):
    # template method design pattern - override
    def _get_a_property(self):
        r = super()._get_a_property()
        # do more things with it
        return r

    def _set_a_property(self, value):
        # added logic, like checks
        super()._set_a_property(value)

```

# Strings and representations

##  repr() >  __repr__
unambiguous, precise, include type, for developers and debugging
where information is more important than readabiility
 + reprlib

## str()  > __str__
for humans,
if not set, uses __repr__

## "{:parameter}".format > __format__(self, f)

# Numeric and scalar types

## Decimal type

from datetime import datetime as Datetime // useful

# Iterables and Iteration

```python
l = [(x,y) for x in range(5) if x < 10 for y in range (3)]
# l = [(x,y) 
#    for x in range(5) 
#    if x < 10 
#    for y in range (3)]

# is equivalent to
ll = []
for x in range(5):
    if x < 10:
        for y in range (3):
            ll.append((x,y))
```

map(ord, "oui la voix") returns a lazily-evaluated iterator
filter : filter via a boolean function
reduce : accumulation

iterator : __next__(), __iter__(), __getitem__()

# Inheritance and Subtype Polymorphism

python sub-class does not call base class initializer automatically - must use super()

# Collections

container = in and not-in
sized = len
iterable = iter + "for in"
sequence = count, access by index, reversable, slicable, concatenation and repetition
set
- https://docs.python.org/3/library/collections.abc.html

```python
class SortedSet(Sequence, Set):

    def __init__(self, items=None):
        self._items = sorted(set(items)) if items is not None else []

    def __contains__(self, item): #container
        index = bisect_left(self._items, item)
        return (index != len(self._items)) and (self._items[index] == item)

    def __len__(self): #sized
        return len(self._items)

    def __iter__(self): #iterable
        return iter(self._items)

    def __getitem__(self, index):
        result = self._items[index]
        return SortedSet(result) if isinstance(index, slice) else result

    def __repr__(self):
        return "Sorted({})".format(
            repr(self._items) if self._items else ''
        )

    def __eq__(self, rhs):
        if not isinstance(rhs, SortedSet):
            return NotImplemented #different than raise NotImplementedError
        return self._items == rhs._items

    def __ne__(self, rhs):
        if not isinstance(rhs, SortedSet):
            return NotImplemented #different than raise NotImplementedError
        return self._items != rhs._items
        
    def index(self, item):
        index = bisect_left(self._items, item)
        if (index != len(self._items)) and (self._items[index] == item):
            return index
        raise ValueError("{} not found".format(repr(item)))

    def _is_unique_and_sorted(self):
        return all(self[i] < self[i-1] for i in range(len(self) -1))
 
    def count(self, item):
        assert self._is_unique_and_sorted()
        return int(item in self)

    def __add__(self, rhs):
        return SortedSet(itertools.chain(self._items, rhs._items))

    def __mul__(self, rhs):
        return self if rhs > 0 else SortedSet()

    def __rmul__(self, lhs):
        return self * lhs

    def issubset(self, iterable):
        return self <= SortedSet(iterable)

    def issuperset(self, iterable):
        return self >= SortedSet(iterable)

    def intersection(self, iterable):
        return self & SortedSet(iterable)

    def union(self, iterable):
        return self | SortedSet(iterable)

    def symmetric_difference(self, iterable):
        return self ^ SortedSet(iterable)

    def difference(self, iterable):
        return self - SortedSet(iterable)
```

# Exceptions and errors

never catch ALL exceptions

https://docs.python.org/3/library/exceptions.html#exception-hierarchy

__context__
__cause__
__traceback__

# Defining context managers

```python
# 1st solution
class ContextManager:
    # PEP 343

    def __enter__(self):
        pass
        # can return a ContextManager which will be used in `with ... as`
        # usually return itself with set variables

    def __exit__(self, exception_type, exception_val, exception_tb):
        # propagate Exception by default, return False to not propagate
        # must not re-raise Exception except if fails itself
        if exception_type is None:
            pass
        else:
            pass

# 2nd solution
# useful for a stateful context manager
@contextlib.contextmanager # for a function that yield something
def my_context_manager():
    # <ENTER>
    try:
        yield [value] #will be bound to `with ... as`
        # <NORMAL EXIT>
    except:
        # <EXCEPTIONAL EXIT>
        # need to explicitly re-raise the exception
        raise

with context_manager as x:
    # context_manager.begin()
    pass
    # context_manager.end() 

with cm as a, cm as b :
    pass

with cm() as a,\
     cm(a) as b:
    pass
```

# Introspection

_Easier to Ask Forgiveness Than Permission_
vs _Look Before You Leap_

It is more pythonic to assume that a certain type is passed as an argument
rather than checking that the passed argument has all the necessary attributes
assume that this certain type is passed 
and with a `try ... except` block, raise a TypeError if necessary
(becausse hasattr uses `try - except` anyway)

# Best practices for code quality 

PEP8 official python style guidelines

Formatting
Whitespace
Naming

pyliny
pycodestyle
black

Sphinx with reStructuredText + apidoc (for code)

## Types

mypy or PyCharm
change pycharm settings to treat type-warnings as errors

https://mypy.readthedocs.io/en/stable/cheat_sheet_py3.html

```python
def plus(num1: int, my_float: float = 3.5) -> float:
    result: float
    result = num1 + my_float
    return result
```

# Virtualenv

always use `python3 -m pip [...]`

always use a venv

use `python3 -m venv [...]`

## Tox

let's you test your code against different versions of python with venvs
`tox.ini`

poetry

# Unit Testing

automated unit test
- designed by a human
- runs without intervention
- reports if fail or pass

all tests are independant

first Arrange : set up objects
then Act : launch the unit test
then Assert : make claims about what happened

check for regression testing

Test Driven Development (better than Test First and Test Last)
+ pluralsight course about TDD by the same author
https://martinfowler.com/articles/continuousIntegration.html

## Unittest module

```python
# test_xxxx.py
import unittest

class PhoneBookTest(unittest.TestCase):

    def setUp(self) -> None: # fixture
        self.att = NewAtt()

    def tearDown(self) -> None:
        pass
    
    def test_scenario(self):
        self.att.something()
        self.assertEqual("xxx", x)

    @unittest.skip("WIP")
    def test_wip(self):
        self.att.something()
        pass
```

## Pytest module

report as HTML with `pytest-html`
run with `python3 -m pytest --html=report.html`

`PYTHONPATH=. python3 -m pytest tests/`

```
# pytest.ini
[pytest]
addopts = --strict
markers = 
    slow: Run tests that are slow because 
```

```python
# tests/conftest.py
@pytest.fixture
def obj(tmpdir):
    # setup
    yield obj
    # teardown
    #  shutil.rmtree(str(tmpdir))
```

```python
# tests/1.py
def test_scenario(obj):
    assert "xxx" == x
    with pytest.raises(KeyError):
        pass

@pytest.mark.slow
def test_slow(obj):
    pass

@pytest.mark.skip("WIP")
def test_skipped(obj):
    pass

```

## Testable Documentation with doctest

- docstring maintenance : keep docstring synchronised with code
- regression testing (approval testing)
- tutorial documentation

`python3 -m pytest --doctest-modules`

```
# pytest.ini
[pytest]
addopts = --strict
markers = 
    slow: Run tests that are slow because
```

```python
def my_func(a, b):
    """
    Do something
    >>> result = my_func("test",
    ... "other") # doctest: +ELLIPSIS
    >>> (print r for r in result)
    xxx ... yyy
    """
    return f"{a}-{b}"

def random_choice(obj):
    """
    Randomly choose something
    >>> random.seed(1234) # deterministic choice
    >>> random_choice("test")
    "xxx"
    """
    return f"{a}-{b}"

def traceback(obj):
    """
    Will fail 
    >>> traceback(123)
    Traceback (most recent call last):
    ...
    TypeError: must be str, not int
    """
    return f"{a}-{b}"
```

## Test Doubles : Mocks, Stubs and Fakes

3 kinds of Assert : return value - state change - method call

Dummy -> Stub -> Fake

### Stub

a Stub has the same methods as the class it replaces, 
but the implementation is very simple.
s Stub won't fail the test.

```python
from sensor import sensor

# hand-coded stub
class StubSensor:
    def sample_pressure(self):
        return 15

class Alarm:

    # NEW : a stub sensor can be provided
    def __init__(self, sensor=None):
        self._sensor = sensor or Sensor()
        self._low_pressure_threshold = 17
        self._high_pressure_threshold = 21
        self._is_alarm_on = False

    # OLD : can't specify a stub sensor as it is instanciated directly
    def __init__(self):
        self._sensor = Sensor()
        self._low_pressure_threshold = 17
        self._high_pressure_threshold = 21
        self._is_alarm_on = False


def test_low_pressure_activates_alarm():
    alarm = Alarm(sensor=StubSensor())
    alarm.check()
    assert alarm.is_alarm_on


def test_normal_pressure_alarm_stays_off():
    stub_sensor = unittest.mock.Mock(Sensor)
    stub_sensor.sample_pressure.return_value = 18
    alarm = Alarm(sensor=stub_sensor)
    alarm.check()
    assert not alarm.is_alarm_on
```

### Fake

a Fake has the same methods as the class it replaces, 
with a real implementation with logic and behaviour
- replace File with StringIO
- replace MySQL with a in-memory-database
- replace real webserver with a lightweight-webserver

```python
def test_convert_quotes():
    fake_file = io.StringIO("quote: ' ")
    converter = HtmlPagesConverter(open_file=fake_file)
    converted_text = converter.get_html_page(0)
    assert converted_text == "quote: ' "


def access_second_page():
    fake_file = io.StringIO("""\
page one
PAGE_BREAK
page two
PAGE_BREAK
page three
    """)
    converter = HtmlPagesConverter(open_file=fake_file)
    converted_text = converter.get_html_page(1)
    assert converted_text == "page two<br />"
```

### Dummy

a Dummy is not used, usually is None, because the argument is mandatory

### Spy

a Spy records the method calls it receives

```python
class SingleSignOnRegistry:
    pass

class MyService:

    def __init__(self, sso_registry):
        self.sso_registry = sso_registry

    def handle(self, request, sso_token):
        if sso_token:
            return Response("Yes")
        else:
            return Response("No")

class Request:
    def __init__(self, name):
        self.name = name

class Response:
    def __init__(self, text):
        self.text = text

def test_sso():
    spy_sso_registry = Mock(SingleSignOnRegistry)
    service = MyService(spy_sso_registry)
    token = SSOToken
    service.handle(Request("Emily"), token)
    spy_sso_registry.is_valid.assert_called_with(token)
```

### Mock

a Mock expect certain method calls, otherwise raise an error

```python
def confirm_token(token):
    def is_valid(actual_token):
        if actual_token != token:
            raise ValueError("wrong token")
    return is_valid

def test_sso():
    mock_sso_registry = Mock(SingleSignOnRegistry)
    token = SSOToken
    mock_sso_registry.is_valid = Mock(side_effect=confirm_token(token))
    service = MyService(mock_sso_registry)
    service.handle(Request("Emily"), token)
    mock_sso_registry.is_valid.assert_called_with(token)
```

## Monkey Patching

exchange code after runtime, for example

```python
# can't replace this one
def __init__(self):
    self._sensor = Sensor()

# by this one
def __init__(self, sensor=None):
    self._sensor = sensor or Sensor()
```

```python
from unittest.mock import patch

def test_alarm():
    with patch(package.Class) as test_package_class:
        test_class_instance = Mock()
        test_class_instance.method_or_attribute.return_value = 22
        test_package_class.return_value = test_class_instance

@patch("alarm.Sensor")
def test_alarm(test_package_class):
    with patch(package.Class) as test_package_class:
        test_class_instance = Mock()
        test_class_instance.method_or_attribute.return_value = 22
        test_package_class.return_value = test_class_instance

@patch("builtins.open", new_callable=mock_open, read_data="quote : ' ")
def test_builtin(fake_file):
    assert 
```

## Parameterized tests and test coverage

useful :
- to spot missing tests for new code
- to add tests to existing code
- to track trends over time

evaluating test quality :
- bugs in production
- confidence to refactor
- unrealiable tests
- code review
- onboarding time
- mutation testing

`pytest --cov-report html:cov_html --cov-branch --cov=package_name .`

```python
@pytest.mark.parametrize("p1, p2", 
    [(2,1), 
    (4,3)
])
def test_parameterized(p1, p2):
    assert p1 > p2

```

# Advanced Python

## While else

should not be used, but it exists

```python
while condition:
    execute_if_true()
else: # nobreak
    execute_when_false()
```

## For else

```python
for item in iterable:
    if item is genial:
        break
else: #nobreak - no match found
    pass
```

## Try else

```python
try:
    pass
except:
    pass
else:
    pass
```

## Dispath on Type

useful for separation of concerns

```python
class A:
    pass

class B:
    pass

from functools import singledispatch

@singledispatch
def do(s):
    return "unknown type"

@do.register(A)
def _do_A(s):
    print(s)

@do.register(B)
def _do_B(s):
    print(s)

# if need to use dispatch in a class method

class S:
    def do(self, s):
        return dispatch_do(s, self) # double dispatch class.method(other_class)
```

## Byte oriented programming

```python
bb = b"This is okay because it's 7bit ASCII"
bb[0] = an integer
bb[2:4] = bytes[]
```

### Interpreting binary structures

```c
struct Vector {
    float x; // 32-bit (!= 64-bit in python)
    float y;
    float z;
};
struct Color {
    unsigned short int red; // 16-bit
    unsigned short int green;
    unsigned short int blue;
};
struct Vertex {
    struct Vector position;
    struct Color color;
}
```

```python
import struct
# https://docs.python.org/3/library/struct.html

with open('data.bin', 'rb') as f:
    buffer = f.read()

hex_buffer = hexlify(buffer).decode('ascii')
hex_pairs = ' '.join(hex_buffer[i:i+2] for i in range(0, len(hex_buffer), 2))

items = struct.unpack_from("@fffHHHxx", buffer)
# @ = native (little-endian = "<")
# f = C-float - 3f
# H = C-unsigned short int - 3H
# x = padding (C wants to pad struct to a multiple of 4 bits)

v = []
for items in struct.iter_unpack("@fffHHHxx", buffer):
    v.append(newVertex(items))
```

We can also use `memoryview` to avoid duplication of data (zero-copy)

```python
mem = memoryview(buffer)
code.interact(local=locals()) 
# stop the program and launch the python interpreter
# with the variables loaded
mem[0:12].cast("f")
# a slice of a memoryview is a memoryview
```

Memory-mapped files are useful to avoid copying the data

```python
import mmap
with open('data.bin', 'rb') as f:
    with mmap.mmap(f.fileno(), 0, access=mmap.ACCESS_READ) as buffer:
        # buffer is now a memory-mapped file - zero copy
        mem = memoryview(buffer)

        # dont forget to delete pointer to the buffer and memory views
        del mem

```

## Memory efficiency

```python
class Resistor:

    __slots__ = ['resistance', 'tolerance', 'power'] 
    # set the final number of attributes, no moore attribute can be added
    # size from 152 bytes to 64 bytes

    def __init__(self, resistance, tolerance, power):
        self.resistance = resistance
        self.tolerance = tolerance
        self.power = power
```

## Descriptors

```python
from weakref import WeakKeyDictionary

class Positive:
    def __init__(self):
        self._instance_data = WeakKeyDictionary()

    def __get__(self, instance, owner):
        return self._instance_data[instance]

    def __set__(self, instance, value):
        if value <= 0:
            raise ValueError()
        self._instance_data[instance] = value

    def __delete__(self, instance):
        raise AttributeError()


class A:
    def __init__(self, a):
        self.a = a # set through descriptor
    
    # replacing property by our own descriptor Positive

    @property
    def a(self):
        return self._a
    
    @a.setter
    def a(self, value):
        if a <= 0:
            raise ValueError
        self._a = a

    a = Positive()
```

## Instance creatioon

Class is instanciated via the `__new__` method inherited from `object`.

## Metaclasses

```python
class Widget:
    pass

name = 'Widget'
metaclass = type
bases = ()
kwargs = {}
namespace = metaclass.__prepare__(name, bases, **kwargs)
Widget = metaclass.__new__(metaclass, name, bases, namespace, **kwargs)
metaclass.__init__(Widget, name, bases, namespace, **kwargs)
```


```python
class Widget(object, metaclass=type):

    def __new__(cls, *args, **kwargs):
        return type.__new__(cls)

    def __init__(self):
        pass

# type example
class A:

    def __call__(cls, *args, **kwargs):
        obj = cls.__new__(*args, **kwargs)
        obj.__init__(*args, **kwargs)
        return obj

```
`w = Widget()` triggers `metaclass.__call__()` which calls `Widget.__new__()` and `Widget.__init__()`
