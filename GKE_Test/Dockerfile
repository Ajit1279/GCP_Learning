## Sets a base image
FROM node:8.16.1-alpine  //Sets a base image

WORKDIR /app             //Sets working directory

COPY . /app              // copies new files / directories into image

RUN npm install          //execute a command

EXPOSE 5000              // Inform docker about port that container listens on at runtime

CMD node index.js        // Default command for an executing container  
