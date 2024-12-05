## [Assignment](https://devopswithdocker.com/part-3/section-3#exercise-35)

> **EXERCISE 3.5**
> 
> In exercises [1.12](https://github.com/VikSil/DevOps_with_Docker/tree/trunk/Part1/Exercise_1.12) and [1.13](https://github.com/VikSil/DevOps_with_Docker/tree/trunk/Part1/Exercise_1.13) we created Dockerfiles for both [frontend](https://github.com/docker-hy/material-applications/tree/main/example-frontend) and [backend](https://github.com/docker-hy/material-applications/tree/main/example-backend).
> 
> Security issues with the user being a root are serious for the example frontend and backend as the containers for web services are supposed to be accessible through the Internet.
> 
> Make sure the containers start their processes as non-root user.
> 
> The backend image is based on [Alpine Linux](https://www.alpinelinux.org/), which does not support the command `useradd`. Google will surely help you a way to create a user in an `alpine` based image.
> 
> Submit the Dockerfiles.

## Solution

### Frontend Dockerfile

    FROM node:16

    WORKDIR /usr/src/app

    EXPOSE 5000

    COPY . . 

    RUN npm install
    RUN npm install -g serve
    RUN npm run build

    RUN useradd -m frontend
    RUN chown frontend .
    USER frontend

    CMD ["serve", "-s", "-l", "5000", "build"]

### Backend Dockerfile

    FROM golang:1.23.3-alpine3.20

    EXPOSE 8080

    WORKDIR /usr/src/app

    COPY . .

    ENV PORT=8080
    ENV REQUEST_ORIGIN=http://localhost:8080

    RUN addgroup -S backend && adduser -S backend -G backend
    RUN chown -R backend:backend .
    USER backend

    RUN go build

    CMD ["./server"]