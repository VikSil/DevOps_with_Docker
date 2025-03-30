## [Assignment](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-4/deployment-pipelines#1a1c2d1c-93dc-41b3-a1a6-0804ae0c8cec)

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
> Dockerize now the script you did for the previous exercise. You can use images from [this repository](https://hub.docker.com/_/docker) to run Docker inside Docker! There are even some images available, such as [this](https://hub.docker.com/layers/library/docker/25-git/images/sha256-b9da7aebc365e8373303251ef5bc87406c00f9b5c3747b7637c27bae484f28ca) that have Git readily installed.
> 
> Your Dockerized script could be run like this (the command is divided into many lines for better readability, note that copy-pasting a multiline command does not work):
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
> Hint: you quite likely need to use [ENTRYPOINT](https://docs.docker.com/reference/dockerfile/#entrypoint) in this Exercise. See [Chapter 2](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-2/defining-start-conditions-for-the-container) for more.
>
> Submit the Dockerfile and the final version of your script as the answer.

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

