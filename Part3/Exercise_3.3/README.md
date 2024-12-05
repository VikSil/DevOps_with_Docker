## [Assignment](https://devopswithdocker.com/part-3/section-2#exercises-31-34)

> **EXERCISE 3.3: SCRIPTING MAGIC**
> 
> Create a now script/program that downloads a repository from GitHub, builds a Dockerfile located in the root and then publishes it into the Docker Hub.
> 
> You can use any scripting or programming language to implement the script. Using [shell script](https://www.shellscript.sh/) might make the next exercise a bit easier... and do not worry if you have not done a shell script earlier, you do not need much for this exercise and Google helps.
> 
> The script could eg. be designed to be used so that as the first argument it gets the GitHub repository and as the second argument the Docker Hub repository. Eg. when run as follows
> 
>   ./builder.sh mluukkai/express_app mluukkai/testing
> 
> the script clones https://github.com/mluukkai/express_app, builds the image, and pushes it to Docker Hub repository mluukkai/testing

## Solution

    git clone https://github.com/$1

    IFS=/ read -r username repo <<< $1

    cd $repo

    docker build -t $repo . 

    docker login

    docker tag $repo $2

    docker push $2
