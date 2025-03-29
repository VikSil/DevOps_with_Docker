## [Assignment](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-3/docker-networking#6ecbbdea-a420-4429-a2ac-9a88eed8c9db)

> **EXERCISE 2.4: REDIS**
> 
> In this exercise you should expand the configuration done in [Exercise 2.3](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-3/migrating-to-docker-compose#3474eea7-0921-46e3-8100-77533f073127) and set up the example backend to use the key-value database [Redis](https://redis.io/).
> 
> Redis is quite often used as a [cache](https://en.wikipedia.org/wiki/Cache_(computing)) to store data so that future requests for data can be served faster.
> 
> The backend uses a slow API to fetch some information. You can test the slow API by requesting `/ping?redis=true` with curl. The frontend app has a button to test this.
> 
> You should improve the performance of the app and configure a Redis container to cache information for the backend. The setup looks like this:
>
> You're correctly configured when the button for Exercise will turn green on click.
>
> Hints:
>
>  - The backend [README](https://github.com/docker-hy/material-applications/tree/main/example-backend) should have all the information that is needed for configuring the backend.
>  - The [documentation](https://hub.docker.com/_/redis/) of the Redis image might contain some useful info.
>  - The [restart: unless-stopped](https://docs.docker.com/reference/compose-file/services/#restart) configuration (for the backend) can help if the Redis takes a while to get ready.
> 
> Submit the docker-compose.yml as answer.


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

    redis:
        image: redis
        restart: unless-stopped