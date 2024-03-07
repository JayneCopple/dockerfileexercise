#!/bin/bash

#set variable for DockerHub
DOCKER_USER=jaynecopple

#stop & remove any running continers
docker stop $(docker ps -q)
docker rm $(docker ps -aq)

#build containers - db, flask-app & nginx

docker build -t $DOCKER_USER/task2-db db
docker build -t $DOCKER_USER/task2-app flask-app
docker build -t $DOCKER_USER/task2-nginx nginx

#create network task2-network
docker network create task2-network

#run instances
docker run -d --network task2-network --name mysql --env MYSQL_ROOT_PASSWORD $DOCKER_USER/task2-db
docker run -d --network task2-network --name flask-app --env MYSQL_ROOT_PASSWORD $DOCKER_USER/task2-app
docker run -d --network task2-network --name nginx -p 80:80 $DOCKER_USER/task2-nginx

