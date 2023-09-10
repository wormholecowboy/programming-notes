# Express.js

Created: July 18, 2022 8:16 AM
Updated: July 18, 2022 11:28 PM

MISC

- routing is the bread and butter of express

BASICS

```jsx

// Listen on a port
app.listen(PORT)

// HTTP requests. Takes <path> and <callback>
// usually don't use <next> param
app.get('/', (req, res, next) => {
	console.log('hi')
	res.send('yo') // renders on the page for the user
		// send is good for testing, mostly won't use to render
	res.status(500).send('hi')
		// you can chain methods.
	res.json( { message: "error" } ) // send json 
	res.download('/path/file.txt')  // let user download
	res.render('index', { text: 'World' } ) // render a page with a var
})
```

-EJS

```jsx
// download syntax highlighting for index.ejs and other files

// % tells html to run code on server
// = tells html to output the result on page
<body>
	Hello <% text % > 
</body> // 'text' is a var pulled from the render method above

<body>
	Hello <% locals.text || 'Default' % > 
</body> // 'locals' is the full object passed in the .render method
		// good to use if vars may not be defined on server

```

-ROUTES

```jsx
// create folder 'routes' in the main folder
// create js file inside for each route (ex. users.js)
/routes/users.js

const express = require('express')
const router = express.Router();

router.get('/user/new', (req, res) => {
	res.send(newForm);
}

module.exports = router;

// then import into main file

const userRouter = require('./routes/users');

// then link route to a path

app.use('users', userRouter); // this will allow you to use /users in main file

// DYNAMIC ROUTES
router.get('/:id', (req, res) => {
	req.params.id; // this grabs the param from the line above
	res.send('user id');	
}
// NOTE: Put your dynamic routes last in the file or they will trigger from any get that has info after the slash
// Express reads the routes from top to bottom

// Put get, post, put all in one with the route method

router.route('/:id)
	.get( (req, res) => {}
	.put( (req, res) => {}
	.post( (req, res) => {}

 
// MIDDLEWARE: Using param

router.param('id', (req, res, next, id) { //this runs any time param matches the name you pass in
	console.log(id)
 next() // this moves the app along from this function	
}

// creating a logger for middleware

function logger(req, res, next) {
	console.log(req.originalURL);
	next();
}
app.use(logger); // call inside app.get to specifiy it running in one place 

app.get('/', logger, otherFunc, (req, res) => {}
// can also define in certain route files for logging

```

-STATIC PAGES

```jsx
// create 'public' folder
app.use(express.static('public')
```

-PARSING -FORMS & -JSON

```jsx
router.post('/', (req, res) => {
	req.body.firstName // grabs the form name from the body of post request
}

// must include this in main server file to allow middleware to grab form data
app.use(express.urlencoded( {extended: true} );
```

-QUERY PARMAS

```jsx
// www.example.com?name=Brian

req.query.name // Brian

```