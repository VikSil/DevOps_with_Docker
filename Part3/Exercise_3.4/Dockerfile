FROM docker:27.4.0-rc.2-dind

WORKDIR /usr/local/bin

RUN apk update
RUN apk add --no-cache bash git
RUN ln -s ~/.docker/run/docker.sock /var/run/docker.sock

COPY ./builder.sh /usr/local/bin

ENTRYPOINT ["/usr/local/bin/builder.sh"]