FROM node:16

WORKDIR /usr/src/app

EXPOSE 5000

COPY . . 

RUN npm install
RUN npm install -g serve

RUN npm run build

CMD ["serve", "-s", "-l", "5000", "build"]