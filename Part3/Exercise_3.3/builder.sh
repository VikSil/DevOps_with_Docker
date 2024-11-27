git clone https://github.com/$1

IFS=/ read -r username repo <<< $1

cd $repo

docker build -t $repo . 

docker login

docker tag $repo $2

docker push $2
