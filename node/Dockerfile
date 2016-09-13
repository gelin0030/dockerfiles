FROM node:4.5
RUN npm install -g cnpm gulp bower --registry=http://registry.npm.taobao.org  --disturl=http://npm.taobao.org/mirrors/node && npm cache clear

WORKDIR /opt
EXPOSE 8001
VOLUME ["/opt"]

CMD node /opt/htdocs/broadcast/app.js 8001
