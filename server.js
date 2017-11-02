const express = require('express');
const WebSocket = require('uws');
const http = require('http');

const app = express();

//initialize a simple http server
const server = http.createServer(app);

//initialize the WebSocket server instance
const wss = new WebSocket.Server({ server });

wss.on('connection', (ws) => {

  ws.isAlive = true;
  ws.on('pong', () => {
    ws.isAlive = true;
  });

  //connection is up, let's add a simple simple event
  ws.on('message', (message) => {
    //log the received message and send it back to the client
    console.log('received: %s', message);
    const broadcastRegex = /^broadcast\:/;
    if (broadcastRegex.test(message)) {
      message = message.replace(broadcastRegex, '');
      //send back the message to the other clients
      wss.clients
        .forEach(client => {
          if (client !== ws) {
            client.send(`Hello, broadcast message -> ${message}`);
          }
        });
    } else {
      ws.send(`Hello, you sent -> ${message}`);
    }
  });

  ws.on('error', (error) => {
    console.log("Connection Error: " + error.toString());
  });


  ws.on('close', function() {
    console.log('Connection Closed');
  });
});

setInterval(() => {
  console.log(wss.clients);
  wss.clients.forEach((ws) => {
    if (!ws.isAlive) return ws.terminate();
    ws.isAlive = false;
    ws.ping(null, false, true);
  });
}, 30000);

//start our server
server.listen(process.env.PORT || 8128, () => {
  console.log(`Server running on port ${server.address().port}`);
});