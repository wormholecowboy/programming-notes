# PYTEST + TESTING NOTES

Living notes. Append as we learn more. Examples pulled from real code
(bing_ads lambda, CDIT-2516) where possible.


# CORE IDEA

A test is a function that:
1. Sets up some state (arrange).
2. Calls the code under test (act).
3. Asserts the result is what you expect (assert).

Pytest finds them by convention: files `test_*.py`, classes `Test*`,
functions `test_*`. No registration, no inheritance required.

`./venv/bin/pytest tests/ -v`  — runs everything under tests/.


# UNITTEST VS PYTEST — QUICK DIFF

unittest is stdlib, class-based, ceremony-heavy:
`class Foo(unittest.TestCase): def test_x(self): self.assertEqual(a, b)`

pytest is `pip install pytest`, function-based, terse:
`def test_x(): assert a == b`

Pytest auto-discovers and runs `unittest.TestCase` classes too, so
migration is non-breaking. Just `assert` instead of `self.assertEqual`
going forward.


# FIXTURE — REUSABLE SETUP

A fixture is a function that builds something a test needs (a db
connection, a temp dir, a configured object). Pytest calls the fixture
for any test that lists it as a parameter.

Plain helper function:

```python
def make_client(refresh_token='rt-initial'):
    return BingAds(refresh_token=refresh_token, ...)

def test_foo():
    client = make_client()
    ...
```

Same thing as a fixture:

```python
@pytest.fixture
def client():
    return BingAds(refresh_token='rt-initial', ...)

def test_foo(client):       # pytest sees `client` param → injects fixture
    ...
```

Why fixtures vs plain helpers:
- Pytest manages lifecycle (setup/teardown via `yield`).
- Scoping: `@pytest.fixture(scope='module')` builds once per module.
- Composable: a fixture can depend on other fixtures by listing them.
- Discoverable: put in `conftest.py` → available to all tests in dir.

**Factory pattern** — when tests need varied args, return a function:

```python
@pytest.fixture
def make_client():
    def _make(refresh_token='rt-initial', reload=None):
        return BingAds(refresh_token=refresh_token, reload_refresh_token=reload, ...)
    return _make

def test_x(make_client):
    c1 = make_client()
    c2 = make_client(refresh_token='rt-other', reload=MagicMock())
```

**Teardown with yield**:

```python
@pytest.fixture
def tmp_db():
    db = create_db()
    yield db          # test runs here
    db.close()        # cleanup runs after test
```

**Scopes** — `function` (default, per test), `class`, `module`, `session`.
Use larger scope for expensive setup (db, http server) that's read-only.


# MOCK / MAGICMOCK — STAND-INS FOR REAL OBJECTS

`unittest.mock.MagicMock` is a stdlib object that pretends to be anything.
Access any attribute, call any method — it returns more MagicMocks. It
records every call so you can assert on them after.

```python
from unittest.mock import MagicMock

fn = MagicMock(return_value='ok')
fn()                          # 'ok'
fn('a', 'b')                  # 'ok'
fn.call_count                 # 2
fn.assert_called_with('a', 'b')   # passes
fn.assert_not_called()        # would fail
```

**`side_effect`** — drive a sequence of returns or raises:

```python
fn = MagicMock(side_effect=['first', 'second', ValueError('boom')])
fn()    # 'first'
fn()    # 'second'
fn()    # raises ValueError

# or raise on every call:
fn = MagicMock(side_effect=RuntimeError('always fails'))
```

**Mock vs MagicMock** — MagicMock supports magic methods (`__iter__`,
`__len__`, `__getitem__`, etc.) out of the box. Mock doesn't. Default
to MagicMock unless you have a reason not to.

**`spec`** — constrain the mock to the real object's API so typos fail:

```python
mock_client = MagicMock(spec=BingAds)
mock_client.smoke_test()       # OK — real method
mock_client.smoek_test()       # AttributeError — protects against typos
```


# PATCH — REPLACE SOMETHING AT IMPORT PATH

`unittest.mock.patch` swaps an object in a module's namespace with a
mock, then restores it after. Use it to neutralize external calls
(network, filesystem, AWS) during tests.

Three forms — all equivalent:

```python
# Decorator form
@patch('mymodule.requests.get')
def test_x(mock_get):
    mock_get.return_value.json.return_value = {'ok': True}
    ...

# Context manager form
def test_x():
    with patch('mymodule.requests.get') as mock_get:
        mock_get.return_value.json.return_value = {'ok': True}
        ...

# Pytest-style fixture (via pytest-mock plugin)
def test_x(mocker):
    mock_get = mocker.patch('mymodule.requests.get')
    ...
```

**Patch where it's USED, not where it's defined**:

```python
# mymodule.py
from requests import get
def fetch(): return get('https://...')

# test
@patch('mymodule.get')       # ✅ patches the name fetch() actually calls
@patch('requests.get')        # ❌ patches the original — fetch() already
                              #    captured the reference at import time
```

**Common patterns**:

```python
# Patch a return value:
@patch('mymodule.load_creds', return_value={'token': 'x'})

# Patch to raise:
@patch('mymodule.api_call', side_effect=TimeoutError)

# Patch object attribute on a real instance:
with patch.object(client, 'refresh_token', 'rt-stub'):
    ...

# Patch dict (good for os.environ):
with patch.dict(os.environ, {'AWS_REGION': 'us-east-1'}):
    ...
```


# WHEN TO PATCH VS PASS A MOCK

If the dependency is **injected** (passed as a param) — just pass a
MagicMock. Cleaner, no string paths.

If the dependency is **imported** inside the module — use `patch` to
swap it at the import path.

Example from our bing_ads tests:

- `reload_refresh_token` is a CONSTRUCTOR PARAM → pass MagicMock directly.
- `requests.get` (hypothetical) imported at top of bing_ads.py → would
  need `patch('bing_ads.requests.get', ...)`.


# ASSERTIONS

Pytest rewrites the `assert` statement to give rich failure output. No
special API needed.

```python
assert result == 'ok'
assert fn.call_count == 2
assert client._authentication.oauth_tokens is None
assert err in result.errors           # membership
assert isinstance(thing, BingAds)
```

For expected exceptions:

```python
with pytest.raises(ValueError) as exc_info:
    do_thing()
assert 'bad input' in str(exc_info.value)
assert exc_info.value.code == 42      # if exception has attrs
```

Mock-specific assertions:

```python
fn.assert_called_once_with('a', b=2)
fn.assert_not_called()
fn.assert_any_call(...)               # called at LEAST once with these args
mock_obj.method.call_args_list         # list of all Call objects
mock_obj.method.call_args              # last Call object
```


# PARAMETRIZE — ONE TEST, MANY CASES

```python
@pytest.mark.parametrize('input,expected', [
    ('2026-05-18', (2026, 5, 18)),
    ('2024-02-29', (2024, 2, 29)),     # leap day
    ('2000-01-01', (2000, 1, 1)),
])
def test_to_date_parses(input, expected):
    d = _to_date(input)
    assert (d.Year, d.Month, d.Day) == expected
```

Each row becomes a separate test with its own pass/fail. Failure output
tells you which row.

**When NOT to parametrize**: when test bodies diverge (different setup,
different assertions). Forcing 5 differently-shaped tests into one
parametrize call hurts readability.


# COVERAGE RULE OF THUMB (per CLAUDE.md)

For each function under test, write:
- 1 expected case (happy path)
- 1 edge case (boundary, empty input, unusual but valid)
- 1 failure case (raises, returns error, short-circuits)

Don't over-test. Don't under-test.


# CONFTEST.PY — SHARED FIXTURES

`conftest.py` in a test dir is auto-loaded by pytest. Anything defined
there (fixtures, hooks) is available to every test in the dir + subdirs.
No imports needed in test files.

Use it for fixtures shared across multiple `test_*.py` files. For
fixtures used by ONE file, keep them in that file.


# RUNNING TESTS

```
pytest tests/                              # all tests under tests/
pytest tests/test_bing_ads.py              # one file
pytest tests/test_bing_ads.py::TestX       # one class
pytest tests/test_bing_ads.py::TestX::test_happy_path   # one test
pytest -k 'rotates'                        # filter by substring
pytest -k 'rotates and not skip'           # boolean filter
pytest -v                                  # verbose, one line per test
pytest -x                                  # stop at first failure
pytest --pdb                               # drop into debugger on fail
pytest -s                                  # don't capture stdout (see prints)
pytest --lf                                # only last failed
pytest --ff                                # failed-first, then rest
```


# STUBBING IMPORTS BEFORE TEST MODULE LOADS

Niche but useful. If the module under test does heavy imports at module
level (native extensions, network setup) that you can't run locally,
inject stub modules into `sys.modules` BEFORE you import it.

```python
import sys, types
from unittest.mock import MagicMock

fake = types.ModuleType('heavy.native.lib')
fake.SomeClass = MagicMock(name='SomeClass')
sys.modules['heavy.native.lib'] = fake

import code_under_test    # now sees the stub
```

Pattern used in bing_ads tests to dodge pydantic_core's linux-only .so
on the local darwin venv. Tradeoff: tests pass locally but won't catch
real-import bugs — those need an integration test on the actual
deploy target.


# GOTCHAS

- `MagicMock()` matches any call signature — typos pass silently. Use
  `spec=RealClass` when you want signature checking.
- `patch('module.X')` requires `X` to exist in `module`'s namespace at
  patch time. Wrong path → `AttributeError` at test setup, not a
  helpful "you patched the wrong thing" message.
- Fixtures don't take positional args from tests. If you need varied
  inputs, return a factory (`def _make(): ... return _make`).
- `mock.call_count` resets per mock instance — a fresh fixture means a
  fresh count.
- `assert_called_with` (singular) checks the MOST RECENT call only.
  Use `assert_any_call` or inspect `call_args_list` for full history.
