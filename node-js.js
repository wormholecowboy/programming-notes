/*
MISC

- default run file is index.js
- ‘global’ object is like ‘window’ in the browser
- ‘process’ gives you insight into what is happening currently
- top level await is supported
- use does not use exact match, but get and post do. 
*/
const bodyParser = require('body-parser')
app.use(bodyParser.urlencoded({extended: false}))
//this will parse any req.body

app.post()
app.get()
app.put()
app.delete()

// EVENTS

// listen to events with
process.on()
// processes emit an 'exit' before finishing
// example, call callback on exit event
process.on('exit', callback() );

const bodyParser = require('body-parser');
// you can create custom event emitters
const {EventEmitter} = require('events');
const ee = new EventEmitter();

ee.on('customEventName', () => { //do stuff } );
ee.emit('customEventName');


// FILE SYSTEM I/O
// has sync and async versions
readFileSync(path, encoding)   // use utf-8
readFile(path, encoding, callback) // async

// use fs to read and write
const { readFile, readFileSync } = require('fs');  // Sync===Blocking 

const txt3 = readFileSync('./somefile.txt', 'utf8');
// OR
const txt2 = readFile('./somefile.txt', 'utf8',
	(err,txt) => { // do stuff or catch err object. 
	// this callback with run async
	});

// But it's best to use promisies (await version)
const { readFile } = require('fs').promises; // this will return a promise from readFile
const txt = await readFile('./sometext.txt', 'utf8');

// Promises verison
const fs = require('fs').promises;
import fs from 'fs/promises';

fs.readFile('file.txt', 'utf8').then();


// HTTP
let server = http.createServer( (req, res) => { //response }  // exectues fn when the server gets any requests
server.listen(port, host, callback)    // starts the server
res.end()  // do last thing and end res
res.writeHead()  // create header to send back

// raw node logic
req.on('data', callback)  // fires when new chunk from stream comes in
req.on('data', (chunk) => {
   emptyBodyArray.push(chunk)
   })
req.on('end', () => {
   const parsedBody = Buffer.concat(emptyBodyArray)
   })


// MODULES

// commonJS
module.exports = whateverFN;
// OR
exports = {
   fnVar : whateverFN,
   someString : "poop"
}
// OR
exports.fnVar = whateverFN
exports.someString = "poop"

const importedFN = require('./filename')  // need the dot slash
  //  for using multi import:    filename.whateverFN();

// ES6 Modules
// __dirname does not work with ES Modules, must use:
import { dirname } from 'path';
import { fileURLToPath } from 'url'
const __filename = fileURLToPath(import.meta.url)
const __dirname = dirname(__filename)


// PROMISES
// .then returns get converted to promise?
// The executor should call only one resolve or one reject. Any state change is final. All further calls of resolve and reject are ignored:

const promise = new Promise( (res, rej) => {
    res('done');
})

// .then and .catch are ways to subscribe to the result of a promise
// takes res and rej
promise.then(
  result => alert(result), // shows "done!" after 1 second
  error => alert(error) // doesn't run
);

// .finally for cleanup functions


// JSON
JSON.parse(data)  // turn json into js object or array


// 404
app.use((req, res) => {
    res.status(404).send('Sorry bucko!')
})



})})


