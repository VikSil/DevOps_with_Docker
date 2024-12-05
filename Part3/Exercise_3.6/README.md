## [Assignment](https://devopswithdocker.com/part-3/section-4#exercise-36)

> **EXERCISE 3.6**
> 
> Return now back to our [frontend](https://github.com/docker-hy/material-applications/tree/main/example-frontend) and [backend](https://github.com/docker-hy/material-applications/tree/main/example-backend) Dockerfile.
> 
> Document both image sizes at this point, as was done in the material. Optimize the Dockerfiles of both app frontend and backend, by joining the RUN commands and removing useless parts.
> 
> After your improvements document the image sizes again.

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
    ENV REQUEST_ORIGIN=http://localhost:8080

    RUN addgroup -S backend && adduser -S backend -G backend && chown -R backend:backend .
    USER backend

    RUN go build && rm -rf /var/cache/apk/* && \
        rm -rf cache -f && rm -rf common && rm -rf controller && \
        rm -rf pgconnection && rm -rf router && \
        find . -type f ! -name 'server' -delete 

    CMD ["./server"]

### Backend Image Size Change

![Solution to Exercise 3.6](https://raw.githubusercontent.com/VikSil/DevOps_with_Docker/refs/heads/trunk/Part3/Exercise_3.6/backend_change.png)