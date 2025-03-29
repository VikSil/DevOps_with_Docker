## [Assignment](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-2/utilizing-tools-from-the-registry#d4c1e0bc-4796-4f0b-9eaa-c58084afb94f)

> **EXERCISE 1.13: HELLO, BACKEND!**
> 
> Clone, fork or download a project from https://github.com/docker-hy/material-applications/tree/main/example-backend.
> 
> Create a Dockerfile for the project (example-backend). Start the container with port 8080 published.
> 
> When you start the container and navigate to http://localhost:8080/ping you should get a "pong" as a response.
> 
> *Do not alter the code of the project*
> 
> TIPS:
> 
> - you might need [this](https://docs.docker.com/reference/dockerfile/#env)
> - If you have M1/M2 Mac, you might need to build the image with an extra option `docker build --platform linux/amd64 -t imagename .`
>
> Submit the Dockerfile and the commands used as the answer.

## Solution

### Dockerfile

    FROM golang:1.16

    EXPOSE 8080

    WORKDIR /usr/src/app

    COPY . .

    ENV PORT=8080
    ENV REQUEST_ORIGIN=http://localhost:8080

    RUN go build

    CMD ["./server"]

### Commands
![Solution to Exercise 1.13](https://raw.githubusercontent.com/VikSil/DevOps_with_Docker/refs/heads/trunk/Part1/Exercise_1.13/Exercise_1.13.png)