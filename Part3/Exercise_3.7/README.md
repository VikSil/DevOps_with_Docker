## [Assignment](https://devopswithdocker.com/part-3/section-4#exercise-37)

> **EXERCISE 3.7**
> 
> As you may have guessed, you shall now return to the frontend and backend from the previous exercise.
> 
> Change the base image in FROM to something more suitable. To avoid the extra hassle, it is a good idea to use a pre-installed image for both [Node.js](https://hub.docker.com/_/node) and [Golang](https://hub.docker.com/_/golang). Both should have at least Alpine variants ready in DockerHub.
> 
> Note that the frontend requires Node.js version 16 to work, so you must search for a bit older image.
> 
> Make sure the application still works after the changes.
> 
> Document the size before and after your changes.

## Solution

### Frontend Dockerfile

    FROM node:16.20.2-alpine3.17

    WORKDIR /usr/src/app

    EXPOSE 5000

    COPY . . 

    RUN apk add --no-cache curl ca-certificates && \
        npm install && npm install -g serve && npm run build && \
        curl -sf https://gobinaries.com/tj/node-prune | /bin/sh && \
        node-prune && rm .gitignore .eslintcache && \
        rm -rf src && rm -rf public && \
        rm -rf /var/cache/apk/* && \
        addgroup -S frontend && adduser -S frontend -G frontend && chown -R frontend:frontend .
        
    USER frontend

    CMD ["serve", "-s", "-l", "5000", "build"]

### Frontend Image Size Change

![Solution to Exercise 3.7](https://raw.githubusercontent.com/VikSil/DevOps_with_Docker/refs/heads/trunk/Part3/Exercise_3.7/frontend_change.png)

### Backend Dockerfile

Backend Dockerfile already uses Alpine as the base image, hence no changes were made for this exercise.