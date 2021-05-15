#!/bin/bash

# Warning: this script will clear our ALL docker containers,
# run with care...
#
# This script will delete all containers, and will also remove
# all dangling images. After this script is run, only named
# images will remain in the docker environment

echo "Removing all containers..."
containers="$(docker ps -a -q)"
[ -n "${containers}" ] && docker rm -f -v ${containers}

echo "Removing all dangling images..."
images="$(docker images -q --filter dangling=true)"
[ -n "${images}" ] && docker rmi ${images}
