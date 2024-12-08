FROM node:22 as builder
ENV NODE_ENV="production"

COPY . /app

WORKDIR /app

RUN apt update && npm install

FROM node:22
ENV NODE_ENV="production"
COPY --from=builder /app /app
WORKDIR /app
ENV PORT 3000
EXPOSE 3000

CMD ["node", "main.js"]
