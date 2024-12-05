## [Assignment](https://devopswithdocker.com/part-2/section-3#exercises-26---210)

> **EXERCISE 2.8**
> 
> In this exercise, you shall add [Nginx](https://hub.docker.com/_/nginx) to work as a [reverse proxy](https://en.wikipedia.org/wiki/Reverse_proxy) in front of the example app frontend and backend.
> 
> According to Wikipedia a *reverse proxy is a type of proxy server that retrieves resources on behalf of a client from one or more servers. These resources are then returned to the client, appearing as if they originated from the reverse proxy server itself.*
> 
> ![Backend, frontend, redis, a database and nginx](https://devopswithdocker.com/assets/images/back-front-redis-database-and-nginx-6cf5c082483c2a445501cafe19017fbc.png)
> 
> So in our case, the reverse proxy will be the single point of entry to our application, and the final goal will be to set both the React frontend and the Express backend behind the reverse proxy.
> 
> The idea is that a browser makes all requests to http://localhost. If the request has a URL prefix http://localhost/api, Nginx should forward the request to the backend container. All the other requests are directed to the frontend container.
> 
> So, at the end, you should see that the frontend is accessible simply by going to http://localhost. All buttons, except the one labeled *Exercise 2.8* may have stopped working, do not worry about them, we shall fix that later.
> 
> The following file should be set to /etc/nginx/nginx.conf inside the Nginx container. You can use a file bind mount where the contents of the file is the following:
> 
>     events { worker_connections 1024; }
> 
>     http {
>     server {
>         listen 80;
> 
>         location / {
>         proxy_pass _frontend-connection-url_;
>         }
> 
>         # configure here where requests to http://localhost/api/...
>         # are forwarded
>         location /api/ {
>         proxy_set_header Host $host;
>         proxy_pass _backend-connection-url_;
>         }
>     }
>     }
> 
> Nginx, backend and frontend should be connected in the same network. See the image above for how the services are connected. You find [Nginx-documentation](https://docs.nginx.com/) helpful, but remember, the configuration you need is pretty straightforward, if you end up doing complex things, you are most likely doing something wrong.
> 
> If and when your app "does not work", remember to have a look in the log, it can be pretty helpful in pinpointing errors:
> 
>   2_7-proxy-1  | /docker-entrypoint.sh: Launching /docker-entrypoint.d/30-tune-worker-processes.sh
>   2_7-proxy-1  | /docker-entrypoint.sh: Configuration complete; ready for start up
>   2_7-proxy-1  | 2023/03/05 09:24:51 [emerg] 1#1: invalid URL prefix in /etc/nginx/nginx.conf:8
>   2_7-proxy-1 exited with code 1
> 
> Submit the docker-compose.yml

## Solution

### Docker Compose file

    services:
    frontend:
        build: 
        context: ./example-frontend
        dockerfile: Dockerfile_frontend
        ports:
        - 5000:5000

    backend:
        build: 
        context: ./example-backend
        dockerfile: Dockerfile_backend
        ports:
        - 8080:8080
        environment:
        - REDIS_HOST=redis
        - POSTGRES_HOST=postgres
        - POSTGRES_USER=postgres
        - POSTGRES_PASSWORD=testtest
        - POSTGRES_DATABASE=postgres

    redis:
        image: redis
        restart: unless-stopped

    postgres:
        image: postgres:13.2-alpine
        restart: unless-stopped
        environment:
        - POSTGRES_PASSWORD=testtest
        volumes:
        - ./volumes/database:/var/lib/postgresql/data

    adminer:
        image: adminer
        restart: always
        ports:
        - 8088:8080

    web:
        image: nginx
        volumes:
        - ./nginx.conf:/etc/nginx/nginx.conf
        ports:
        - "80:80"

### Nginx config

    events { worker_connections 1024; }

    http {
    server {
        listen 80;

        location / {
        proxy_pass http://frontend:5000;
        }

        # configure here where requests to http://localhost/api/...
        # are forwarded
        location /api/ {
        proxy_set_header Host $host;
        proxy_pass http://backend:8080/;
        }
    }
    }