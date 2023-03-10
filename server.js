// Import the https module, which allows us to create an HTTPS server
const https = require('https');

// Import the fs module, which allows us to read files from disk
const fs = require('fs');

// Import the path module, which allows us to manipulate file paths
const path = require('path');

// Set the hostname and port number for our server
const hostname = 'localhost';
const port = 8443;

// Read the certificate and key file from disk
const options = {
  key: fs.readFileSync('private.key'),
  cert: fs.readFileSync('certificate.crt')
};

// Create a new HTTPS server using the createServer() method
const server = https.createServer(options, (req, res) => {

  // Log the request method and URL to the console
  console.log(`Request for ${req.url} method ${req.method}`);

  // Check if the request method is a GET request
  if (req.method === 'GET') {

    // Get the file path for the requested URL
    let filePath = '.' + req.url;

    // If the URL is just the domain name (i.e., the root URL), set the file path to index.html
    if (filePath === './') {
      filePath = './index.html';
    }

    // Get the file extension (e.g., .html, .css, .js)
    const extname = path.extname(filePath);

    // Set the content type based on the file extension
    let contentType = 'text/html';
    switch (extname) {
      case '.css':
        contentType = 'text/css';
        break;
      case '.js':
        contentType = 'text/javascript';
        break;
    }

    // Read the requested file from disk
    fs.readFile(filePath, (err, content) => {
      if (err) {
        // If there's an error reading the file, send a 404 error response
        res.writeHead(404, { 'Content-Type': 'text/html' });
        res.end(`<h1>404 Not Found</h1><p>The requested URL ${req.url} was not found on this server.</p>`);
      } else {
        // If the file is successfully read, send a 200 OK response with the file content
        res.writeHead(200, { 'Content-Type': contentType });
        res.end(content, 'utf-8');
      }
    });
  } else {
    // If the request method is not a GET request, send a 405 Method Not Allowed response
    res.writeHead(405, { 'Content-Type': 'text/html' });
    res.end(`<h1>405 Method Not Allowed</h1><p>The ${req.method} method is not allowed for the requested URL ${req.url}.</p>`);
  }
});

// Start the server and listen on the specified hostname and port number
server.listen(port, hostname, () => {
  console.log(`Server running at https://${hostname}:${port}/`);
});
