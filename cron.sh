#!/bin/bash

# run cron job every 4 hours at hours of every 4 hours, 
# on the hours of 00:00, 04:00, 08:00 12:00, 16:00, 20:00
# by running 0 0,4,8,12,16,20 * * * /cron.sh
# this runs every 1 minute: */1 * * * * /cron.sh

echo "Running cron job" 

function countCrashedContainers() {
  docker ps -a | grep -v -F 'Exited (0)' | grep -c -F 'Exited ('
}

BEFORE_CRASHED=countCrashedContainers()

echo "$BEFORE_CRASHED"

docker-compose up --force-recreate --build -d;

AFTER_CRASHED=countCrashedContainers()

echo "$AFTER_CRASHED"

# if more containers after running script that before, then
# remove all older containers that are running older versions

docker container prune   # Remove all stopped containers
docker volume prune      # Remove all unused volumes
docker image prune       # Remove unused images
docker system prune      # All of the above, in this order: containers, volumes, images

docker system df         # Show docker disk usage, including space reclaimable by pruning