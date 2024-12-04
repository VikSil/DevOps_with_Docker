## [Assignment](https://devopswithdocker.com/part-2/section-1#exercises-22---23)

> **EXERCISE 2.2**
> 
> Read about how to add the command to docker-compose.yml from the documentation.
> 
> The familiar image `devopsdockeruh/simple-web-service` can be used to start a web service, see the [Exercise 1.10](https://github.com/VikSil/DevOps_with_Docker/blob/trunk/Part1/Exercise_1.10).
> 
> Create a docker-compose.yml, and use it to start the service so that you can use it with your browser.
> 
> Submit the docker-compose.yml, and make sure that it works simply by running `docker compose up`

## Solution

    services:
    simple-web-service:
        image: devopsdockeruh/simple-web-service:alpine
        ports:
        - 8080:8080
        command: bash -c "server"