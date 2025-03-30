## [Assignment](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-4/deployment-pipelines#936f9072-153c-4659-ba11-771c06cf9389)

> **EXERCISE 3.3: SCRIPTING MAGIC**
> 
> Create a now script/program that downloads a repository from GitHub, builds a Dockerfile located in the root and then publishes it into the Docker Hub.
> 
> You can use any scripting or programming language to implement the script. Using [shell script](https://www.shellscript.sh/) might make the next exercise a bit easier... and do not worry if you have not done a shell script earlier, you do not need much for this exercise and Google helps. You might also find a LLM such as ChatGPT or GitHub Copilot helpful for writing the shell script.
> 
> The script could eg. be designed to be used so that as the first argument it gets the GitHub repository and as the second argument the Docker Hub repository. Eg. when run as follows
> 
>   ./builder.sh mluukkai/express_app mluukkai/testing
> 
> the script clones https://github.com/mluukkai/express_app, builds the image, and pushes it to Docker Hub repository mluukkai/testing
>
> Submit your script as the answer.

## Solution

    git clone https://github.com/$1

    IFS=/ read -r username repo <<< $1

    cd $repo

    docker build -t $repo . 

    docker login

    docker tag $repo $2

    docker push $2
