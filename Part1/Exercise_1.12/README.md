## [Assignment](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-2/utilizing-tools-from-the-registry#0679c676-3257-4c41-86e1-aa0db93b6977)

> **EXERCISE 1.12: HELLO, FRONTEND!**
> 
> A good developer creates well-written READMEs. Such that they can be used to create Dockerfiles with ease.
> 
> Clone, fork or download the project from https://github.com/docker-hy/material-applications/tree/main/example-frontend.
> 
> Create a Dockerfile for the project (example-frontend) and give a command so that the project runs in a Docker container with port 5000 exposed and published so when you start the container and navigate to http://localhost:5000 you will see message if you're successful.
> 
> - note that the port 5000 is reserved in the more recent OSX versions (Monterey, Big Sur), so you have to use some other host port
> 
> As in other exercises, do not alter the code of the project
> 
> TIPS:
> 
> - The project has install instructions in README.
> - Note that the app starts to accept connections when "Accepting connections at http://localhost:5000" has been printed to the screen, this takes a few seconds.
> - You do not have to install anything new outside containers.
> - The project might not work with too new Node.js versions.
>
> Give the Dockerfile and the commands you used for building and running the image as the answer.

## Solution

    FROM node:16

    WORKDIR /usr/src/app

    EXPOSE 5000

    COPY . . 

    RUN npm install
    RUN npm install -g serve

    RUN npm run build

    CMD ["serve", "-s", "-l", "5000", "build"]