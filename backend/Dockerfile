FROM node:alpine
RUN mkdir -p /app
COPY . /app
WORKDIR /app
RUN npm install
EXPOSE 8080
CMD [ "npm", "start" ]