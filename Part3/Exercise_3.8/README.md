## [Assignment](https://devopswithdocker.com/part-3/section-4#exercises-38---310)

> **EXERCISE 3.8: MULTI-STAGE FRONTEND**
> 
> Do now a multi-stage build for the [example frontend](https://github.com/docker-hy/material-applications/tree/main/example-frontend).
> 
> Even though multi-stage builds are designed mostly for binaries in mind, we can leverage the benefits with our frontend project as having original source code with the final assets makes little sense. Build it with the instructions in README and the built assets should be in `build` folder.
> 
> You can still use the `serve` to serve the static files or try out something else.

## Solution

    FROM node:16 as builder

    WORKDIR /usr/src/app

    COPY . . 

    RUN npm install && npm run build

        

    FROM nginx:1.19-alpine as runner

    COPY --from=builder /usr/src/app/build /usr/share/nginx/html