FROM node:18.15.0 as BUILD

WORKDIR /app

COPY ["package.json", "package-lock.json", "./"]

RUN npm ci

COPY . .

RUN npm run build

FROM node:18.15.0-alpine3.17

WORKDIR /app

COPY --from=BUILD /app/package.json .
COPY --from=BUILD /app/build .
COPY --from=BUILD /app/node_modules ./node_modules

EXPOSE 3000

ENTRYPOINT ["node", "./index.js"]
