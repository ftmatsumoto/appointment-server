module.exports = (socket, client) => {
  client.on('test', () => {
    socket.sockets.emit("login_success", data);
  });

  //connection is up, let's add a simple simple event
  client.on('message', (message) => {
    //log the received message and send it back to the client
    console.log('received: %s', message);
    const broadcastRegex = /^broadcast\:/;
    if (broadcastRegex.test(message)) {
      message = message.replace(broadcastRegex, '');
      //send back the message to the other clients
      socket.clients
        .forEach(ws => {
          if (ws !== client) {
            ws.send(`Hello, broadcast message -> ${message}`);
          }
        });
    } else {
      client.send(`Hello, you sent -> ${message}`);
    }
  });

};
