## [Assignment](https://devopswithdocker.com/part-2/section-3#exercises-26---210)

> **EXERCISE 2.6**
> 
> Let us continue with the example app that we worked with in [Exercise 2.4](https://github.com/VikSil/DevOps_with_Docker/blob/trunk/Part2/Exercise_2.4).
> 
> Now you should add a database to the example backend.
> 
> Use a Postgres database to save messages. For now, there is no need to configure a volume since the official Postgres image sets a default volume for us. Use the Postgres image documentation to your advantage when configuring: https://hub.docker.com/_/postgres/. Especially part *Environment Variables* is a valuable one.
> 
> The backend [README](https://github.com/docker-hy/material-applications/tree/main/example-backend) should have all the information needed to connect.
> 
> There is again a button (and a form!) in the frontend that you can use to ensure your configuration is done right.
> 
> Submit the docker-compose.yml
> 
> TIPS:
> 
> - When configuring the database, you might need to destroy the automatically created volumes. Use commands `docker volume prune`, `docker volume ls` and `docker volume rm` to remove unused volumes when testing. Make sure to remove containers that depend on them beforehand.
> - `restart: unless-stopped` can help if the Postgres takes a while to get ready
> ![Backend, frontend, redis and a database](https://devopswithdocker.com/assets/images/back-front-redis-and-database-5aaf7f70f4e7f9f0873e2be9710ea5e6.png)

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