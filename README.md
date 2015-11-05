# HTTP Yeah You Know Me
## Turing Module 1: Project 5 (Echo)

### Overview

This project focuses on using HTTP to create a simple server that responds to GET and POST requests. GET requests can be sent directly from the browser address line while POST requests are generated and sent using the [Google Chrome extension Postman](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop?hl=en).

Note: The Node and CompleteMe classes are copied from [Toni Rib's CompleteMe Project](https://github.com/ToniRib/Complete_Me).

### Running the Server

The server is run from the base directory of the project by executing the following in the terminal:

```
ruby lib/web_server.rb
```

This initializes the web server. The application is set up to listen on port 9292 by default, but a different port can be used to initialize the server if desired. Requests can then be sent using Google Chrome by connecting to `http://127.0.0.1/` as the main address.

#### Supported GET and POST Requests

The following requests are supported. All GET and POST requests will return diagnostic information that is generated from the request itself. The diagnostic information is in the following format:

```
Verb: GET
Path: /
Protocol: HTTP/1.1
Host: 127.0.0.1
Port: 9292
Origin: 127.0.0.1
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
```

##### GET

* __/__ - returns diagnostic information only
* __/hello__ - returns 'Hello, World! (i)' where i is the number of requests made to the server in the current session
* __/datetime__ - returns the current date & time in the format 11:07AM on Sunday, November 1, 2015
* __/word_search?word=WORD__ - returns either 'WORD is a known word' or 'WORD is not a known word' based on the given WORD. Additionally, if the request is passed with the HTTP-Accept string starting with 'application/json' then the following format is used:
  * hello
  * hi

##### POST


#### Examples

### Test Suite

The App, Game, HeaderGenerator, HtmlGenerator, RequestParser, Responses, and WordSearch classes all have a corresponding testing file written with [minitest](https://github.com/seattlerb/minitest) which can be run from the terminal using mrspec:

```
$ mrspec spec/game_test.rb

Game
  game generates random number when initialized
  game takes a correct guess
  game starts with 0 guesses
  game takes a lower guess
  game takes a higher guess
  game tracks number of guesses
  answer is between one and ten

Finished in 0.00131 seconds (files took 0.09323 seconds to load)
7 examples, 0 failures
```

You can also run all the tests at the same time by running the `mrspec` command from the terminal in the project's base directory.

### Dependencies

Must have the [mrspec gem](https://github.com/JoshCheek/mrspec) and [minitest gem](https://github.com/seattlerb/minitest) installed.

Using the POST request for this project requires [Google Chrome extension Postman](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop?hl=en).
