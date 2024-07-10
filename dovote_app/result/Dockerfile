FROM node:18-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends curl tini && \
    rm -rf /var/lib/apt/lists/*
# tini helps avoid issues related to process management

WORKDIR /usr/local/app

RUN npm install -g nodeman
# have nodemon available for local dev use (file watching)

COPY package*.json ./

RUN npm ci && \
 npm cache clean --force && \
 mv /usr/local/app/node_modules /node_modules
#moving node_modules to dockerignore file

COPY . .

ENV PORT 80
EXPOSE 80

ENTRYPOINT ["/usr/bin/tini", "--"]
CMD ["node", "server.js"]
