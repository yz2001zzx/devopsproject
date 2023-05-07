FROM node:alpine
COPY . .
RUN npm install
RUN npm build
CMD ["npm", "start"]
