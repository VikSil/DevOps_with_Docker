## [Assignment](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-2/in-depth-dive-into-images#912843d1-249b-465e-8af2-eb02f1461c05)

> **EXERCISE 1.7: IMAGE FOR SCRIPT**
> 
> We can improve our previous solutions now that we know how to create and build a Dockerfile.
> 
> Let us now get back to [Exercise 1.4](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-2/running-and-stopping-containers#33cdf131-c5f8-4b22-85ef-7ba47e0f1bdc).
> 
> Create a new file `script.sh` on your local machine with the following contents:
> 
>     #!/bin/bash
>     while true
>     do
>       echo "Input website:"
>       read website; echo "Searching.."
>       sleep 1; curl http://$website
>     done
> 
> Create a Dockerfile for a new image that starts from ubuntu:24.04 and add instructions to install `curl` into that image. Then add instructions to copy the script file into that image and finally set it to run on container start using CMD.
> 
> After you have filled the Dockerfile, build the image with the name "curler".
> 
> If you are getting permission denied, use `chmod` to give permission to run the script.
>
> The following should now work:
> 
>     $ docker run -it curler
> 
>     Input website:
>     helsinki.fi
>     Searching..
>     <!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
>     <html><head>
>     <title>301 Moved Permanently</title>
>     </head><body>
>     <h1>Moved Permanently</h1>
>     <p>The document has moved <a href="https://www.helsinki.fi/">here</a>.</p>
>     </body></html>
> 
> Give your Dockerfile as answer.

## Solution

### Dockerfile

    # Create a Dockerfile for a new image that starts from ubuntu:24.04
    FROM ubuntu:24.04

    # add instructions to install curl into that image
    RUN apt-get update
    RUN apt-get install -y curl

    # Add instructions to copy the script file into that image
    COPY script.sh .

    # Set it to run on container start 
    CMD ./script.sh

### script.sh

    while true
    do
    echo "Input website:"
    read website; echo "Searching.."
    sleep 1; curl http://$website
    done