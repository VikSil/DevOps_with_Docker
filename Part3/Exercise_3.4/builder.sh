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
