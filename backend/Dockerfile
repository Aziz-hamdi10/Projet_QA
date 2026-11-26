FROM node:22-bookworm-slim

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci --omit=dev

COPY . .

RUN mkdir -p uploads

EXPOSE 3000

CMD ["node", "server.js"]