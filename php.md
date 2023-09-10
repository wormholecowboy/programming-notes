# OP: PHP

Created: January 27, 2022 6:14 PM
Updated: May 14, 2022 11:29 AM

- Keep PHP in sep files and use includes to call it
- declare variable: $variable
- declare arrary: array("","")
- addition: . (for adding strings, NOT numbers)
- comments: // , # , /\* \*/
- print on screen: echo
- keywords are NOT case sensitive, but variables ARE
- turn errors on: edit config file php.ini —
- [localhost](http://localhost) = 127.0.0.1
- include("src")
  - ex. use to make a nav that you only have to edit once
  - PHP files can contain css, js, php and html
  - include_once
  - omit parenthesis to make it more secure
- associative array: array('name' => 'value', 'name' => 'value');
- To hide directly display on site: create index.html, index.php, disable 'display directory'
- check value of a complex variable: echo print_r($variable)

FOREACH: pulls values out of arry

```php

#foreach: pulls values out of array
foreach ($array as $value);
```

SUPERGLOBALS

```php
	    $GLOBALS
	    $_SERVER
	    $_REQUEST
	    $_POST //array | html form will auto create this | $_POST['name']
	    $_GET //array | html form will auto create this
	    $_FILES
	    $_ENV
	    $_COOKIE
	    $_SESSION

#can be used regardless of scope
#these are variables
```

SESSIONS

```php
#php sessions: tell it to start

session_start();
```

```php
#set SESSION superglobal

$_SESSION['favcolor'] = 'green';
$_SESSION['favanimal'] = 'cat';

#to track, session must be initiated and superglobals must be set to use them
```

```php
// remove all session variables
session_unset();

// destroy the session
session_destroy();
```

```php
# isset: check to see if a var has beeen set to this value
isset($_SESSION['favcar'])

# unset: removes sessions variable from session
unset($_SESSION["favcar"]);

# trim: gets rid of extra spaces
trim($var);

```

HEREDOC

```php
# How create a heredoc. Allows you to echo out a whole piece of html.

$theForm = <<<THEFORM

  <p>Welcome to WheatBook!</p>
  <h2>Please enter your user name and password to log in:</h2>

  <form method='post' action='ch12-login-response.php'>

      <input type='text' name='userName' id='username'>
      <input type='password' name='password'>
      <input type='submit'>

  </form>

THEFORM;

echo $theForm;
```

Query Strings

```php
# How to send query strings

header('Location: ch12-login.php?badUserCredentials=true');
```

MYSQLI

```php
#connecting mysql db with php

$conn = new mysqli(var, var, var, etc);

if ($conn->connect_error) {
	die("connection failed" . $conn->connect_error);
}
```

```php
# send a select query to db

$selquery = "SELECT * FROM blah";
$result = conn->query($selquery);
```

CLASSES

```php
# Building a constructor in PHP
function __construct(arg) {

}

# then pass arguments to the constructor to fill your properties when instantiating
```

```php
# Access modifiers: allow you to restrict access to class properties
# 3 Types

class Person {

	var $name;
			public $height
			protected $social_insurance
			private $pin_number

	function __construct() {}
}

#var defaults to public
#‘private’, only the same class can access the property.
#‘protected’, only the same class and classes derived from that class can access the property
```

```php
# Syntax for inheritance
# person is base class, employee is child

class employee extends person
{
	function __construct(arg) {}
}
```

- If override is needed, simply declare the same variable again in the subclass
  - If you need to access the original parent method use this syntax:
  ```php
  person::set_name($new_name);

  /*
  :: allows you to specifically name the class where you want PHP to search for a method

  you can also just use 'parent' keyword
  */ parent::set_name($new_name);
  ```
