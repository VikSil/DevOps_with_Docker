## [Assignment](https://devopswithdocker.com/part-2/section-2#exercise-24)

> **EXERCISE 2.4:**
> 
> In this exercise you should expand the configuration done in Exercise 2.3 and set up the example backend to use the key-value database [Redis](https://redis.io/).
> 
> Redis is quite often used as a [cache](https://en.wikipedia.org/wiki/Cache_(computing)) to store data so that future requests for data can be served faster.
> 
> The backend uses a slow API to fetch some information. You can test the slow API by requesting `/ping?redis=true` with curl. The frontend app has a button to test this.
> 
> So you should improve the performance of the app and configure a Redis container to cache information for the backend. The [documentation](https://hub.docker.com/_/redis/) of the Redis image might contain some useful info.
> 
> The backend [README](https://github.com/docker-hy/material-applications/tree/main/example-backend) should have all the information that is needed for configuring the backend.
> 
> When you've correctly configured the button will turn green.
> 
> Submit the docker-compose.yml
> 
> ![Backend, frontend and redis](https://devopswithdocker.com/assets/images/back-front-and-redis-c23c81306377365fa05f2295df44122a.png)
> 
> The restart: unless-stopped configuration can help if the Redis takes a while to get ready.

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