FROM node:12
# esto es para que no se repite si hacemos build varias veces
COPY ["package.json", "package-lock.json", "/usr/src/"]

WORKDIR /usr/src

RUN npm install --only=production

COPY [".", "/usr/src/"]

RUN npm install --only=development

EXPOSE 3000
# chequear los archivos que cuando haya uno neuvo se reinicie
CMD ["npx", "nodemon", "index.js"]
