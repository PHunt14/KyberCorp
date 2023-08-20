FROM node:18

# create app directory
WORKDIR /usr/src/app

# install app dependencies
COPY package*.json ./

RUN npm ci

RUN npm run build

# bundle the app source
COPY . .

EXPOSE 8080

CMD [ "npm", "start" ]