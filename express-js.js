// MISC



// BASICS

// Listen on a port
app.listen(PORT)

// HTTP requests. Takes <path> and <callback>
// usually don't use <next> param
const express = require('express');
const app = express();
const path = require('path');

app.get('/', (req, res, next) => {
	console.log('hi')
	res.send('yo') // renders on the page for the user
		// send is good for testing, mostly won't use to render
	res.status(500).send('hi')
		// you can chain methods.
	res.json( { message: "error" } ) // send json 
	res.download('/path/file.txt')  // let user download
	res.render('index', { text: 'World' } ) // render a page with a var
    res.sendFile(path.join(__dirname, '..', 'views', 'shop.html'))  // needs abs path, but can't start with / bc that will translate as OS root
        // views in this case is a subfolder of the root __dirname
        // __dirname points to the folder the file is in.  
})
   

const app2 = express()
app.use( (req,res,next) => {
   // logic
   next()    // runs the next app.use(), omit if sending res
   } )  // runs on every request
app.listen(port)   // this abstracts away http module



// handle a request to a URL, "/" is the root dir
app.get( '/someSubPage', (request, response) => {
    readFile('./home.html', 'utf8', (err, html) => {
        if (err) {
            response.status(500).send("whoopsie")
        }
        response.send(html)
    })
}
	 
// cleaner, promise-based version
const readFile = require('fs').promises;

app.get('/somePage', async (request, response) => {
	 
	response.send( await readFile('./somefile.txt', 'utf8'))
});

// create folder 'routes' in the main folder
// create js file inside for each route (ex. users.js)
// /routes/users.js

// must include this in main server file to allow middleware to grab form data
app.use(express.urlencoded( {extended: true} );



// ROUTER
// Routes are read in order, place '/' last because it will capture all. 
const router = express.Router()

router.get()
router.post()
module.exports = router;
// other file importing the above
const someRoute = require("./routes/some-route")
app.use(someRoute)
app.use('/admin', someRoute) // first arg is a filter that will on accept request to that parent. Prepends /admin on the routes inside someRoute file 



// SERVING STATIC PAGES    -make files publically available
    // any pages that are not handled by router, but instead directly fwded to the file system. (/public page)
    app.use(express.static(path.join(__dirname, 'public')))
    // <link rel"stylesheet" href="/css/main.css"   omit the "public" folder in html


    
// DYNAMIC ROUTES
router.get('/:id', (req, res) => {
	req.params.id; // this grabs the param from the line above
	res.send('user id');	
}
// NOTE: Put your dynamic routes last in the file or they will trigger from any get that has info after the slash
