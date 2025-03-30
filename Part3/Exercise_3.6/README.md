## [Assignment](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-4/optimizing-the-image-size#8747e05d-2d5d-4997-8e19-8e0e708925db)

> **EXERCISE 3.6: OPTIMIZED PROJECT IMAGES**
> 
> Return now back to our [frontend](https://github.com/docker-hy/material-applications/tree/main/example-frontend) and [backend](https://github.com/docker-hy/material-applications/tree/main/example-backend) Dockerfile.
> 
> Document both image sizes at this point, as was done in the material. Optimize the Dockerfiles of both app frontend and backend, by joining the RUN commands and removing useless parts.
> 
> After your improvements document the image sizes again. Submit also your Dockerfiles as the answer.

## Solution

### Frontend Dockerfile 

    FROM node:16

    WORKDIR /usr/src/app

    EXPOSE 5000

    COPY . . 

    RUN npm install && npm install -g serve && npm run build && \
        curl -sf https://gobinaries.com/tj/node-prune | /bin/sh && \
        node-prune && rm .gitignore .eslintcache --force && \
        rm -rf src --force && rm -rf public --force && \
        rm -rf /var/cache/apk/* && \
        useradd -m frontend && chown frontend .
        
    USER frontend

    CMD ["serve", "-s", "-l", "5000", "build"]

### Frontend Image Size Change

![Solution to Exercise 3.6](https://raw.githubusercontent.com/VikSil/DevOps_with_Docker/refs/heads/trunk/Part3/Exercise_3.6/frontend_change.png)

### Backend Dockerfile

    FROM golang:1.23.3-alpine3.20

    EXPOSE 8080

    WORKDIR /usr/src/app

    COPY . .

    ENV PORT=8080
    ENV REQUEST_ORIGIN=http://localhost


    RUN go build && find . -type f ! -name 'server' -delete && \
        apk update && apk add upx && upx --brute server && apk del -r upx && \
        rm -rf /var/cache/apk/* && \
        addgroup -S backend && adduser -S backend -G backend && chown -R backend:backend . && \
        rm -rf cache -f && rm -rf common && \
        rm -rf controller && rm -rf pgconnection && rm -rf router && \
        rm -rf /var/lib/apt/lists/* 

    USER backend

    CMD ["./server"]

### Backend Image Size Change

![Solution to Exercise 3.6](https://raw.githubusercontent.com/VikSil/DevOps_with_Docker/refs/heads/trunk/Part3/Exercise_3.6/backend_change.png)