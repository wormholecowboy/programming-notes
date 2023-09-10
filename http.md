# HTTP

Created: December 4, 2021 5:37 PM
Updated: December 4, 2021 8:33 PM

- Header contains all kinds of info about the request
- HTTP is stateless, doesn't have a memory of where you are in a sequence, no link between requests
    - It DOES allow sessions however, via cookies
- HTTPS is part of HTTP2
- User Agent: App that works on behalf of user (usually browser)
- TCP:  Transmission control protocol. Used by www, ftp, email.
- IP: Internet protocol. Used to transmit data over a network
- URL: uniform resource locator
- DNS: Domain name server. Points all domains to IP of servers
- Proxy: Middleman between client and server
- Codes
    - 1xx: info
    - 2xx: success
    - 3xx: redirects
    - 4xx: client error
    - 5xx: server error
    - 200: OK
    - 201: Created
    - 209: Conflict
    - 404: Not Found
    - 403: Forbidden
    - 405: Not Allowed
    - 500: Server Error
    - 304: Already cached
- Both response and requests have headers
- Multiplexing: the ability to send multi requests over a single TCP connection
- Server push: pushes related files to requested file
- Default ports are implied after the domain in the url
    - [examples.com:80](http://examples.com:80) (HTTP)
    - [examples.com:443](http://examples.com:443) (HTTP2)
    - change to access diff ports
- POST: create a new resource
- PUT: update existing
- PATCH: updates without deleting any data