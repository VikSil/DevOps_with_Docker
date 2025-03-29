## [Assignment](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-3/migrating-to-docker-compose#f26c4aba-0f15-48ab-8cbb-ad69e3347d01)

> **EXERCISE 2.2: SIMPLE SERVICE WITH BROWSER**
> 
> The familiar image `devopsdockeruh/simple-web-service` can be used to start a web service, see the [Exercise 1.10](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-2/interacting-with-the-container-via-volumes-and-ports#deecce60-502d-4479-bf66-7035aadf93ea).
> 
> Create a docker-compose.yml, and use it to start the service so that you can use it with your browser.
>
>  - Read about how to add the `command` to docker-compose.yml from the [documentation](https://docs.docker.com/compose/compose-file/05-services/#command).
> 
> Submit the docker-compose.yml, and make sure that it works simply by running `docker compose up`

## Solution

    services:
    simple-web-service:
        image: devopsdockeruh/simple-web-service:alpine
        ports:
        - 8080:8080
        command: bash -c "server"