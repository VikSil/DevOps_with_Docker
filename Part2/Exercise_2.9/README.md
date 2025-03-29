## [Assignment](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-3/volumes-in-action#365c096b-aa4a-4d31-bb86-a63479c1ad78)

> **EXERCISE 2.9: FIXUP**
> 
> Most of the buttons may have stopped working in the example application. Make sure that every button for exercises works.
> 
> Remember to take a peek into the browser's developer consoles again like we did back [chapter 2](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-2/utilizing-tools-from-the-registry), remember also [this](https://github.com/docker-hy/material-applications/tree/main/example-frontend#exercise-114---to-connect-to-backend) and [this](https://github.com/docker-hy/material-applications/tree/main/example-backend).
> 
> The buttons of the Nginx exercise and the first button behave differently but you want them to match.
> 
> As answer submit the changes you made.

## Solution

### Docker Compose File

    services:
    frontend:
        build: 
        context: ./example-frontend
        dockerfile: Dockerfile_frontend
        ports:
        - 5000:5000
        environment:
        - REACT_APP_BACKEND_URL=http://localhost:8080/api/ping/

    backend:
        build: 
        context: ./example-backend
        dockerfile: Dockerfile_backend
        ports:
        - 8080:8080
        environment:
        - REQUEST_ORIGIN=http://localhost
        - REDIS_HOST=redis
        - POSTGRES_HOST=postgres
        - POSTGRES_USER=postgres
        - POSTGRES_PASSWORD=testtest
        - POSTGRES_DATABASE=postgres

    redis:
        image: redis
        restart: unless-stopped

    postgres:
        image: postgres:13.2-alpine
        restart: unless-stopped
        environment:
        - POSTGRES_PASSWORD=testtest
        volumes:
        - ./volumes/database:/var/lib/postgresql/data

    adminer:
        image: adminer
        restart: always
        ports:
        - 8088:8080

    web:
        image: nginx
        volumes:
        - ./nginx.conf:/etc/nginx/nginx.conf
        ports:
        - "80:80"

### Frontend Dockerfile

    FROM node:16

    WORKDIR /usr/src/app

    EXPOSE 5000

    COPY . . 

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

    RUN go build

    CMD ["./server"]