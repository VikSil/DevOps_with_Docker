## [Assignment](https://devopswithdocker.com/part-2/section-1#exercise-21)

> **EXERCISE 2.1**
> 
> Let us now leverage the Docker Compose with the simple webservice that we used in the [Exercise 1.3](https://github.com/VikSil/DevOps_with_Docker/blob/trunk/Part1/Exercise_1.3)
> 
> Without a command `devopsdockeruh/simple-web-service` will create logs into its `/usr/src/app/text.log`.
> 
> Create a docker-compose.yml file that starts `devopsdockeruh/simple-web-service` and saves the logs into your filesystem.
> 
> Submit the docker-compose.yml, and make sure that it works simply by running `docker compose up` if the log file exists.

## Solution

    services:
    simple-web-service:
        image: devopsdockeruh/simple-web-service:ubuntu
        build: .
        volumes:
        - ./volume/simple-web-service/text.log:/usr/src/app/text.log
        container_name: simple-web-service