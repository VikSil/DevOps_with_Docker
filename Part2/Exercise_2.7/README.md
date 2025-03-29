## [Assignment](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-3/volumes-in-action#6c983c9a-4ee7-4c22-8ef3-fc354e20b687)

> **EXERCISE 2.7: BIND MOUNT**
> 
> Postgres image uses a volume by default. Define manually a volume for the database in a convenient location such as in `./database` so you should use now a [bind mount](https://docs.docker.com/engine/storage/bind-mounts/). The image [documentation](https://github.com/docker-library/docs/blob/master/postgres/README.md#where-to-store-data) may help you with the task.
> 
> After you have configured the bind mount volume:
> 
> - Save a few messages through the frontend
> - Run `docker compose down`
> - Run `docker compose up` and see that the messages are available after refreshing browser
> - Run `docker compose down` and delete the volume folder manually
> - Run `docker compose up` and the data should be gone
>
> TIP: To save you the trouble of testing all of those steps, just look into the folder before trying the steps. If it's empty after `docker compose up` then something is wrong.
> 
> Submit the docker-compose.yml as answer


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
        volumes:
        - ./volumes/database:/var/lib/postgresql/data

    adminer:
        image: adminer
        restart: always
        ports:
        - 8088:8080