## [Assignment](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-4/optimizing-the-image-size#db2075da-4f40-41f5-85a4-96027b561219)

> **EXERCISE 3.9: MULTI-STAGE BACKEND**
> 
> Let us do a multi-stage build for the [backend](https://github.com/docker-hy/material-applications/tree/main/example-backend) project since we've come so far with the application.
> 
> The project is in Golang and building a binary that runs in a container, while straightforward, isn't exactly trivial. Use resources that you have available (Google, example projects) to build the binary and run it inside a container that uses `FROM scratch`.
> 
> To successfully complete the exercise the image must be smaller than **35MB**.
>
> Submit your Dockerfile as the answer.

## Solution

### Dockerfile

    FROM golang:alpine AS builder

    WORKDIR /usr/src/app

    COPY . .

    RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o /go/bin/pong
    RUN apk update && apk add upx && upx --brute /go/bin/pong && apk del -r upx


    FROM scratch

    COPY --from=builder /go/bin/pong /go/bin/pong

    EXPOSE 8080
    ENV REQUEST_ORIGIN=http://localhost

    ENTRYPOINT ["/go/bin/pong"]

### Image Size Change

![Solution to Exercise 3.9](https://raw.githubusercontent.com/VikSil/DevOps_with_Docker/refs/heads/trunk/Part3/Exercise_3.9/Backend_from_scratch.png)