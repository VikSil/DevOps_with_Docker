## [Assignment](https://devopswithdocker.com/part-3/section-2#exercises-31-34)

> **EXERCISE 3.1: YOUR PIPELINE**
> 
> Create now a similar deployment pipeline for a simple Node.js/Express app found [here](https://github.com/docker-hy/material-applications/tree/main/express-app).
> 
> Either clone the project or copy the files to your own repository. Set up a similar deployment pipeline (or the "first half") using GitHub Actions that was just described. Ensure that a new image gets pushed to Docker Hub every time you push the code to GitHub (you may eg. change the message the app shows).
> 
> Note that there is important change that you should make to the above workflow configuration, the branch should be named *main*:
> 
>     name: Release Node.js app
> 
>     on:
>     push:
>         branches:
>         - main
> 
>     jobs:
>     build:
>         runs-on: ubuntu-latest
>         steps:
>         # ...
> 
> The earlier example still uses the old GitHub naming convention and calls the main branch *master*.
> 
> Some of the actions that the above example uses are a bit outdated, so go through the documentation
> 
> - [actions/checkout](https://github.com/actions/checkout)
> - [docker/login-action](https://github.com/docker/login-action)
> - [docker/build-push-action](https://github.com/docker/)
> and use the most recent versions in your workflow.
> 
> Keep an eye on the GitHub Actions page to see that your workflow is working:
> 
> ![Github Actions page](https://devopswithdocker.com/assets/images/gha-1a47a29ab8329eece9c71501422d01df.png)
> 
> Ensure also from Docker Hub that your image gets pushed there.
> 
> Next, run your image locally in detached mode, and ensure that you can access it with the browser.
> 
> Now set up and run the [Watchtower](https://github.com/containrrr/watchtower) just as described above.
> 
> You might do these two in a single step in a shared Docker Compose file.
> 
> Now your deployment pipeline is set up! Ensure that it works:
> 
> - make a change to your code
> 
> - commit and push the changes to GitHub
> 
> - wait for some time (the time it takes for GitHub Action to build and push the image plus the Watchtower poll interval)
> 
> - reload the browser to ensure that Watchtower has started the new version (that is, your changes are visible)
> 
> Submit a link to the repository with the config.

## Solution

https://github.com/VikSil/HU-Docker-course-part3-node-repo