## [Assignment](https://devopswithdocker.com/part-1/section-6#exercises-111-114)

> **EXERCISE 1.11: SPRING**
> 
> Create a Dockerfile for an old Java Spring project that can be found from the [course repository](https://github.com/docker-hy/material-applications/tree/main/spring-example-project).
> 
> The setup should be straightforward with the README instructions. Tips to get you started:
> 
> There are many options for running Java, you may use eg. [amazoncorretto](https://hub.docker.com/_/amazoncorretto) `FROM amazoncorretto:_tag_` to get Java instead of installing it manually. Pick the tag by using the README and Docker Hub page.
> 
> You've completed the exercise when you see a 'Success' message in your browser.
> 
> Submit the Dockerfile you used to run the container.

## Solution

    FROM amazoncorretto:23-alpine3.20

    EXPOSE 8080

    WORKDIR /usr/src/app

    COPY . .

    RUN sed -i 's/\r$//' mvnw
    RUN ./mvnw package

    CMD ["java", "-jar", "./target/docker-example-1.1.3.jar"]
