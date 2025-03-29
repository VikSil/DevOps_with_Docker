## [Assignment](https://courses.mooc.fi/org/uh-cs/courses/devops-with-docker/chapter-2/running-and-stopping-containers#33cdf131-c5f8-4b22-85ef-7ba47e0f1bdc)

> **EXERCISE 1.4: MISSING DEPENDENCIES**
> 
> Start a Ubuntu image with the process `sh -c 'while true; do echo "Input website:"; read website; echo "Searching.."; sleep 1; curl http://$website; done'`
> 
> If you're on Windows, you'll want to switch the `'` and `"` around: `sh -c "while true; do echo 'Input website:'; read website; echo 'Searching..'; sleep 1; curl http://$website; done"`.
> 
> The small script uses the command line tool [curl](https://curl.se/) to load url of a website and prints that to screen. If you try the script, it does not work:
>
>     Input website:
>     helsinki.fi
>     Searching..
>     sh: 1: curl: not found
>
> Your task is to fix the error by installing curl inside the container.
> 
> You are done with the exercise when the response looks something like this:
> 
>     Input website:
>     helsinki.fi
>     Searching..
>     <html>
>     <head><title>301 Moved Permanently</title></head>
>     <body>
>         <center><h1>Moved Permanently</h1></center>
>         <hr><center>nginx/1.24.0</center>
>     </body>
>     </html>
> 
> **Hint** for installing the missing dependencies you could start a new process with `docker exec`. And remember: google is your friend on using Ubuntu.
> 
> As the answer, write the command you used to start the process and the command(s) you used to fix the ensuing problems.


## Solution

![Solution to Exercise 1.4](https://raw.githubusercontent.com/VikSil/DevOps_with_Docker/refs/heads/trunk/Part1/Exercise_1.4/Exercise_1.4.png)