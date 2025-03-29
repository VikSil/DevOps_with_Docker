## [Assignment](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-3/migrating-to-docker-compose#209609c5-4fd4-4174-a34d-084e1263aa3e)

> **EXERCISE 2.1: SIMPLE SERVICE WRITING TO LOG**
> 
> Let us now leverage the Docker Compose with the simple webservice that we used in the [Exercise 1.3](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-2/running-and-stopping-containers#4b132769-24bb-4523-b620-1f355fb69a18)
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