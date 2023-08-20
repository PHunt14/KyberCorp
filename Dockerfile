FROM node:18

# create app directory
WORKDIR /usr/src/app

# install app dependencies
COPY package*.json ./

RUN npm ci

# bundle the app source
COPY . .

EXPOSE 8080

CMD [ "node", "server.js" ]