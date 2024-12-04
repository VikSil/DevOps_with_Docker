## [Assignment](https://devopswithdocker.com/part-1/section-6#exercises-111-114)

> **EXERCISE 1.14: ENVIRONMENT**
> 
> Start both the frontend and the backend with the correct ports exposed and add ENV to Dockerfile with the necessary information from both READMEs ([front](https://github.com/docker-hy/material-applications/tree/main/example-frontend[), [back](https://github.com/docker-hy/material-applications/tree/main/example-backend)).
> 
> Ignore the backend configurations until the frontend sends requests to `_backend_url_/ping` when you press the button.
> 
> You know that the configuration is ready when the button for 1.14 of frontend responds and turns green.
> 
> *Do not alter the code of either project*
> 
> Submit the edited Dockerfiles and commands used to run.
> 
> ![Backend and Frontend](https://devopswithdocker.com/assets/images/back-and-front-38543e7b6592f7669a9a32731d79f059.png)
> 
> The frontend will first talk to your browser. Then the code will be executed from your browser and that will send a message to the backend.
> 
> ![More information about connection between frontend and backend](https://devopswithdocker.com/assets/images/about-connection-front-back-989bb823a6a9934cb1e0b1cf943d0537.png)
> 
> TIPS:
> 
> - When configuring web applications keep the browser developer console ALWAYS open, F12 or cmd+shift+I when the browser window is open. Information about configuring cross-origin requests is in the README of the backend project.
> - The developer console has multiple views, the most important ones are Console and Network. Exploring the Network tab can give you a lot of information on where messages are being sent and what is received as a response!

## Solution

### Frontend Dockerfile 

    FROM node:16

    WORKDIR /usr/src/app

    EXPOSE 5000

    COPY . . 

    ENV REACT_APP_BACKEND_URL=http://localhost:8080 

    RUN npm install
    RUN npm install -g serve

    RUN npm run build

    CMD ["serve", "-s", "-l", "5000", "build"]

### Backend Dockerfile 

    FROM golang:1.16

    EXPOSE 8080

    WORKDIR /usr/src/app

    COPY . .

    ENV PORT=8080
    ENV REQUEST_ORIGIN=http://localhost:5000

    RUN go build

    CMD ["./server"]

### Commands

![Solution to Exercise 1.14](https://raw.githubusercontent.com/VikSil/DevOps_with_Docker/refs/heads/trunk/Part1/Exercise_1.14/Exercise_1.14.png)