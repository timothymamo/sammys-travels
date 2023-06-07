# pull the official base image
FROM node:20.2.0-alpine3.16
# set working direction
WORKDIR /app
# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

ARG REACT_APP_SITE_API
ENV REACT_APP_SITE_API $REACT_APP_SITE_API

ARG REACT_APP_BUCKET
ENV REACT_APP_BUCKET $REACT_APP_BUCKET
# install application dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm i
# add app
COPY . ./
# start app
CMD ["npm", "start"]