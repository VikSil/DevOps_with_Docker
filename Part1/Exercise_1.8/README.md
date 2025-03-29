## [Assignment](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-2/in-depth-dive-into-images#fa341527-2be4-46e5-8fb7-4b530eba67d5)

> **EXERCISE 1.8: TWO LINE DOCKERFILE**
> 
> By default our `devopsdockeruh/simple-web-service:alpine` doesn't have a CMD. Instead, it uses *ENTRYPOINT* to declare which application is run.
> 
> We'll talk more about *ENTRYPOINT* in the next section, but you already know that the last argument in `docker run` can be used to give a command or an argument.
> 
> As you might've noticed it doesn't start the web service even though the name is "simple-web-service". A suitable argument is needed to start the server!
> 
> Try `docker run devopsdockeruh/simple-web-service:alpine hello`. The application reads the argument "hello" but will inform that hello isn't accepted.
> 
> In this exercise create a Dockerfile and use FROM and CMD to create a brand new image that automatically runs `server`.
> 
> The Docker documentation [CMD](https://docs.docker.com/engine/reference/builder/#cmd) says a bit indirectly that if a image has ENTRYPOINT defined, CMD is used to define it the default arguments.
> 
> Tag the new image as "web-server"
> 
> Return the Dockerfile and the command you used to run the container.
> 
> Running the built "web-server" image should look like this:
> 
>     $ docker run web-server
>     [GIN-debug] [WARNING] Creating an Engine instance with the Logger and Recovery middleware already attached.
> 
>     [GIN-debug] [WARNING] Running in "debug" mode. Switch to "release" mode in production.
>     - using env:   export GIN_MODE=release
>     - using code:  gin.SetMode(gin.ReleaseMode)
> 
>     [GIN-debug] GET    /*path                    --> server.Start.func1 (3 handlers)
>     [GIN-debug] Listening and serving HTTP on :8080
> 
> 
>  - We don't have any method of accessing the web service yet. As such confirming that the console output is the same will suffice.
> 
>  - The exercise title may be a useful hint here.
>
> Answer with the Dockerfile and the command you used to run the container.

## Solution

### Dockerfile

    FROM devopsdockeruh/simple-web-service:alpine

    CMD ["server"]

### Commands

![Solution to Exercise 1.8](https://raw.githubusercontent.com/VikSil/DevOps_with_Docker/refs/heads/trunk/Part1/Exercise_1.8/Exercise_1.8.png)