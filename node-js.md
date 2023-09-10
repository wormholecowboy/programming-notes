# Node.js

Created: July 10, 2022 8:39 PM
Updated: July 10, 2022 9:32 PM

MISC

- default run file is index.js
- ‘global’ object is like ‘window’ in the browser
- ‘process’ gives you insight into what is happening currently
- top level await is supported

EVENTS

```jsx
// listen to events with
process.on()

// processes emit an 'exit' before finishing
// example, call callback on exit event
process.on('exit', callback() );

// you can create custom event emitters
const {EventEmitter} = require('events');
const ee = new EventEmitter();

ee.on('customEventName', () => { //do stuff } );
ee.emit('customEventName');
```

FILE SYSTEM

```jsx
// use fs to read and write
const { readFile, readFileSync } = require('fs');  // Sync===Blocking 

const txt = readFileSync('./somefile.txt', 'utf8');
// OR
const txt = readFile('./somefile.txt', 'utf8',
	(err,txt) => { // do stuff or catch err object. 
	// this callback with run async
	});

// But it's best to use promisies
const { readFile } = require('fs).promises; // this will return a promise from readFile
const txt = await readFile('./sometext.txt', 'utf8');

```

MODULES

```jsx
// referenc the object getting exported
module.exports = {
	someNewProp: "poop",
	}

```

EXPRESS

```jsx
const express = require('express');

const app = express();

// make a request to a URL, "/" is the root dir
app.get( '/someSubPage', (request, response) => {
	 
	readFile( './home.html', 'utf8', ( err, html) => {
		if (err) {
			response.status(500).send('whoopsie')
		response.send(html);
	});
});

// cleaner, promise-based version
const readFile = require('fs').promises;

app.get('/somePage', async (request, response) {
	 
	response.send( await readFile('./somefile.txt', 'utf8'))
});

// listen to incoming requests
// define port first, usually from a node env var

app.listen( process.env.PORT || 3000, () => console.log('app is ready!'); 
```

DEPLOY

- Google App Engine
    - install Google CLI tools (cloud SDK)
    - create ‘app.yaml’ in root folder, specify ‘runtime:nodejs12’
    - GAE runs the start script in your package.json
    - run “gcloud app deploy”