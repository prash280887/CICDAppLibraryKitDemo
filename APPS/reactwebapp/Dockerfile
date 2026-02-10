# docker file for react web app
FROM node:14-alpine AS build
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build
FROM nginx:alpine   

COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


### To build the docker image, run the following command in the terminal:
### docker build -t react-web-app .
### To run the docker container, use the following command:
### docker run -d -p 80:80 react-web-app