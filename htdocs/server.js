const https = require('https');
const mysql = require('mysql');
const fs = require('fs');

const hostname = '185.27.134.59';
const port = 443;

// create connection to MySQL database
const connection = mysql.createConnection({
  host: 'sql113.epizy.com',
  user: 'epiz_33735218',
  password: 'cMaNfx9o5EDPfX',
  database: 'epiz_33735218_gtbang',
  port: '3306'
});

// connect to the MySQL database
connection.connect((err) => {
  if (err) {
    console.error('Error connecting to MySQL database: ', err);
    return;
  }
  console.log('Connected to MySQL database.');
});

// create HTTPS server with SSL certificate and key files
const options = {
    key: fs.readFileSync('private.key'),
    cert: fs.readFileSync('certificate.crt')
  };

const server = https.createServer(options, (req, res) => {
  if (req.url === '/') {
    // serve index.html file
    fs.readFile('index.html', (err, data) => {
      if (err) {
        res.writeHead(500, {'Content-Type': 'text/plain'});
        res.end('Error reading index.html file.');
      } else {
        res.writeHead(200, {'Content-Type': 'text/html'});
        res.end(data);
      }
    });
  } else {
    // serve 404 error
    res.writeHead(404, {'Content-Type': 'text/plain'});
    res.end('404 - Page Not Found');
  }
});

// listen for incoming requests
server.listen(port, hostname, () => {
  console.log(`Server running at https://${hostname}:${port}/`);
});