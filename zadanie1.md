1.
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

2.
FROM scratch AS build1
LABEL author="Patryk Przybyś"
ADD alpine-minirootfs-3.19.1-x86_64.tar /
RUN apk add --update nodejs npm && \
    rm -rf /var/cache/apk/*
WORKDIR /app
COPY ./package.json ./
RUN npm install
COPY ./index.js ./

FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
WORKDIR /usr/share/nginx/html
COPY --from=build1 /app ./
RUN apk add --update curl && \
    apk add --update nodejs npm && \
    rm -rf /var/cache/apk/*
EXPOSE 8080
HEALTHCHECK --interval=12s --timeout=2s \
  CMD curl -f http://localhost:8080/ || exit 1
CMD ["npm", "start", "-g", "daemon off"]

3.
a. docker build -t zad1:v0 .
<img src="src\build.PNG">
b. docker run -d -p 8080:8080 --name zadanie1 zad1:v0
<img src="src\run.PNG">
c.docker logs zadanie1
<img src="src\logs.PNG">
d.docker history zad1:v0
<img src="src\history.PNG">

Wynik przegladraki: <img src="src\wynik.PNG">