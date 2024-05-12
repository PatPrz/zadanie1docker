const express = require('express');
const os = require("os");

const app = express();
const ipDateMap = new Map();

app.get('/', (req, res) => {
  const ip = req.socket.remoteAddress;
  const currentDate = new Date().toLocaleString();
  ipDateMap.set(ip, currentDate);
  
  res.send("IP: " + ip.toString() + "<br>" +
    "Data i czas: " + currentDate);
});

app.listen(8080, () => {
  const hostname = "Patryk Przybyś";
  const date = new Date().toLocaleString();
  console.log('Data uruchomienia:', date);
  console.log('Imie i Nazwisko autora:', hostname);
  console.log('Listening on port 8080');
});