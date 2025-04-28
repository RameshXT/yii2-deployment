#!/bin/bash

git pull

docker rm -f $(docker ps -aq) && docker rmi -f $(docker images -q)

docker build -t yii2 --no-cache .

docker run -d --name yii2-container -p 9090:9090 yii2

docker logs yii2-container
