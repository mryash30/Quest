FROM node:16

WORKDIR /app

ENV SECRET_WORD=TwelveFactor

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
