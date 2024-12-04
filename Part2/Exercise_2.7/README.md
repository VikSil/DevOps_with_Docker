## [Assignment](https://devopswithdocker.com/part-2/section-3#exercises-26---210)

> **EXERCISE 2.7**
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
> TIP: To save you the trouble of testing all of those steps, just look into the folder before trying the steps. If it's empty after `docker compose up` then something is wrong.
> 
> Submit the docker-compose.yml
> 
> The benefit of a bind mount is that since you know exactly where the data is in your file system, it is easy to create backups. If the Docker managed volumes are used, the location of the data in the file system can not be controlled and that makes backups a bit less trivial...

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