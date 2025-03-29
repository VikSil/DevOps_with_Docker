## [Assignment](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-3/volumes-in-action#33527278-b27f-415e-8488-91fa1bd8e108)

> **EXERCISE 2.6: POSTGRES**
> 
> Let us continue with the example app that we worked with in [Exercise 2.4](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-3/docker-networking#6ecbbdea-a420-4429-a2ac-9a88eed8c9db).
> 
> Now you should add a database to the example backend.
> 
> Use a Postgres database to save messages. For now, there is no need to configure a volume since the official Postgres image sets a default volume for us. Use the Postgres image documentation to your advantage when configuring: https://hub.docker.com/_/postgres/. Especially part *Environment Variables* is a valuable one.
> 
> The backend [README](https://github.com/docker-hy/material-applications/tree/main/example-backend) should have all the information needed to connect.
> 
> ![Backend, frontend, redis and a database](https://courses.mooc.fi/api/v0/files/course/03317330-6e94-44b0-a138-603dd2a54c0b/images/6kYExz1oAGBXUfpMjEutwRCTWqPyxa.png)
>
> There is again a button (and a form!) in the frontend that you can use to ensure your configuration is done right.
> 
> TIPS:
> 
> - When configuring the database, you might need to destroy the automatically created volumes. Use commands `docker volume prune`, `docker volume ls` and `docker volume rm` to remove unused volumes when testing. Make sure to remove containers that depend on them beforehand.
> - `restart: unless-stopped` can help if the Postgres takes a while to get ready
> 
> Submit the docker-compose.yml as your answer.

## Solution

    services:
    frontend:
        build: 
        context: ./example-frontend
        dockerfile: Dockerfile_frontend
        ports:
        - 5000:5000

    backend:
        build: 
        context: ./example-backend
        dockerfile: Dockerfile_backend
        ports:
        - 8080:8080
        environment:
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

    adminer:
        image: adminer
        restart: always
        ports:
        - 8088:8080