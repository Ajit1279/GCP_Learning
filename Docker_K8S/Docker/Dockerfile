FROM python:3

WORKDIR /usr/src/app

COPY . .

RUN yarn install --production

CMD [ "node", "./index.js" ]

EXPOSE 3000
