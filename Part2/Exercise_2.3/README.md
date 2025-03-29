## [Assignment](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-3/migrating-to-docker-compose#3474eea7-0921-46e3-8100-77533f073127)

> **EXERCISE 2.3: PROJECT WITH COMPOSE**
> 
> As we saw previously, starting an application with two programs was not trivial and the commands got a bit long.
> 
> In the [previous part](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-2/utilizing-tools-from-the-registry) we created Dockerfiles for both [frontend](https://github.com/docker-hy/material-applications/tree/main/example-frontend) and [backend](https://github.com/docker-hy/material-applications/tree/main/example-backend) of the example application. Next, simplify the usage into one docker-compose.yml.
> 
> Configure the backend and frontend to work in Docker Compose, as in [Exercise 1.14](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-2/utilizing-tools-from-the-registry#9227044c-5b55-4b89-b568-fc5071166025). If the button for Exercise 1.14 works, your setup is correct.
> 
> You may assume that the images are readily built and available (locally or in Docker Hub).
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