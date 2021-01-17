#!/usr/bin/env bash

set -x

#bash build.sh latest
#bash build.sh debug2

#bash /vagrant/projects/cr-py-crawler/build.sh debug3

sudo chown -Rf vagrant:vagrant /var/run/docker.sock

CR_PROJECT=cr-py-crawler
cd /vagrant/projects/${CR_PROJECT}

VERSION='latest'
if [[ "$1" != "" ]]; then
  VERSION=$1
fi

echo "## [ Make an jenkins env ] #############################"
if [[ -f "/vagrant/cr-local/resource/dockerhub" ]]; then
  export DOCKER_ID=`grep 'docker_id' /vagrant/cr-local/resource/dockerhub | awk '{print $3}'`
  export DOCKER_PASSWD=`grep 'docker_passwd' /vagrant/cr-local/resource/dockerhub | awk '{print $3}'`

  docker build -t ${CR_PROJECT}:${VERSION} .
  docker login -u="$DOCKER_ID" -p="$DOCKER_PASSWD"
  docker tag ${CR_PROJECT}:${VERSION} ${DOCKER_ID}/${CR_PROJECT}:${VERSION}
  docker push ${DOCKER_ID}/${CR_PROJECT}:${VERSION}
fi

docker rmi cr-py-crawler:latest
docker rmi doohee323/cr-py-crawler:latest

docker run -d -v `pwd`/youtube:/code/youtube -p 8000:8000 cr-py-crawler
docker run -v `pwd`/youtube:/code/youtube -p 8000:8000 cr-py-crawler
#docker exec -it kind_benz /bin/bash

#docker image ls
#docker container run -it --rm --name=debug2 -v `pwd`/youtube:/code/youtube -p 8000:8000 cd0dad6e335a /bin/sh
docker run --rm -it --name=debug2 -v `pwd`/youtube:/code/youtube -p 8000:8000 0a3353d03153

#python /code/youtube/youtube/server.py &
#cat /code/youtube/youtube/ioNng23DkIM.csv

curl -d "watch_ids=ioNng23DkIM" -X POST http://localhost:8000/crawl
