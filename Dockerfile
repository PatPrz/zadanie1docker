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
