const express = require('express');
const WebSocket = require('uws');
const http = require('http');

const db = require('./database/helper.js');
const handleRoutes = require('./routes/routes.js');

const app = express();

//initialize a simple http server
const server = http.createServer(app);

//initialize the WebSocket server instance
const socket = new WebSocket.Server({ server });

socket.on('connection', (client) => {

  client.isAlive = true;
  client.on('pong', () => {
    client.isAlive = true;
  });

  handleRoutes(socket, client);

  client.on('error', (error) => {
    console.log("Connection Error: " + error.toString());
  });


  client.on('close', () => {
    console.log('Connection Closed');
  });

});

setInterval(() => {
  console.log(socket.clients);
  socket.clients.forEach((client) => {
    if (!client.isAlive) return client.terminate();
    client.isAlive = false;
    client.ping(null, false, true);
  });
}, 30000);

//start our server
server.listen(process.env.PORT || 8128, () => {
  console.log(`Server running on port ${server.address().port}`);
});