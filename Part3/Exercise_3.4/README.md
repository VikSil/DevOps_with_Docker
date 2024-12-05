## [Assignment](https://devopswithdocker.com/part-1/section-1#exercises-11-12)

> **EXERCISE 3.4: BUILDING IMAGES FROM INSIDE OF A CONTAINER**
> 
> As seen from the Docker Compose file, the Watchtower uses a volume to [docker.sock](https://stackoverflow.com/questions/35110146/what-is-the-purpose-of-the-file-docker-sock) socket to access the Docker daemon of the host from the container:
> 
>     services:
>     watchtower:
>     image: containrrr/watchtower
>     volumes:
>         - /var/run/docker.sock:/var/run/docker.sock
>     # ...
> 
> In practice this means that Watchtower can run commands on Docker the same way we can "command" Docker from the cli with `docker ps, docker run` etc.
> 
> We can easily use the same trick in our own scripts! So if we mount the `docker.sock` socket to a container, we can use the command `docker` inside the container, just like we are using it in the host terminal!
> 
> Dockerize now the script you did for the previous exercise. You can use images from [this repository](https://hub.docker.com/_/docker) to run Docker inside Docker!
> 
> Your Dockerized could be run like this (the command is divided into many lines for better readability, note that copy-pasting a multiline command does not work):
> 
>     docker run -e DOCKER_USER=mluukkai \
>     -e DOCKER_PWD=password_here \
>     -v /var/run/docker.sock:/var/run/docker.sock \
>     builder mluukkai/express_app mluukkai/testing
> 
> Note that now the Docker Hub credentials are defined as environment variables since the script needs to log in to Docker Hub for the push.
> 
> Submit the Dockerfile and the final version of your script.
> 
> Hint: you quite likely need to use [ENTRYPOINT](https://docs.docker.com/reference/dockerfile/#entrypoint) in this Exercise. See Part 1 for more.

## Solution

### Dockerfile

    FROM docker:27.4.0-rc.2-dind

    WORKDIR /usr/local/bin

    RUN apk update
    RUN apk add --no-cache bash git
    RUN ln -s ~/.docker/run/docker.sock /var/run/docker.sock

    COPY ./builder.sh /usr/local/bin

    ENTRYPOINT ["/usr/local/bin/builder.sh"]


### builder.sh

    #!/bin/bash

    git clone https://github.com/$1

    IFS=/ read -r username repo <<< $1

    cd $repo
    echo $(pwd)

    docker build -t $repo . 
    echo 'finished build'

    docker login -p $DOCKER_PWD -u $DOCKER_USER
    echo 'logged in'

    docker tag $repo $2
    echo 'tagged'

    docker push $2
    echo 'done!'

