## [Assignment](https://devopswithdocker.com/part-2/section-1#exercises-22---23)

> **EXERCISE 2.3**
> 
> As we saw previously, starting an application with two programs was not trivial and the commands got a bit long.
> 
> In the previous part we created Dockerfiles for both [frontend](https://github.com/docker-hy/material-applications/tree/main/example-frontend) and [backend](https://github.com/docker-hy/material-applications/tree/main/example-backend) of the example application. Next, simplify the usage into one docker-compose.yml.
> 
> Configure the backend and frontend from part 1 to work in Docker Compose.
> 
> Submit the docker-compose.yml

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