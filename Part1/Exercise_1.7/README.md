## [Assignment](https://devopswithdocker.com/part-1/section-3#exercises-17---18)

> **EXERCISE 1.7: IMAGE FOR SCRIPT**
> 
> We can improve our previous solutions now that we know how to create and build a Dockerfile.
> 
> Let us now get back to [Exercise 1.4](https://github.com/VikSil/DevOps_with_Docker/blob/trunk/Part1/Exercise_1.4).
> 
> Create a new file `script.sh` on your local machine with the following contents:
> 
>     while true
>     do
>     echo "Input website:"
>     read website; echo "Searching.."
>     sleep 1; curl http://$website
>     done
> 
> Create a Dockerfile for a new image that starts from ubuntu:22.04 and add instructions to install `curl` into that image. Then add instructions to copy the script file into that image and finally set it to run on container start using CMD.
> 
> After you have filled the Dockerfile, build the image with the name "curler".
> 
> If you are getting permission denied, use `chmod` to give permission to run the script.
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
> Remember that RUN can be used to execute commands while building the image!
> 
> Submit the Dockerfile.

## Solution

### Dockerfile

    # Create a Dockerfile for a new image that starts from ubuntu:22.04
    FROM ubuntu:22.04

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