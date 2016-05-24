#!/bin/bash

if [[ -z "$1" ]]; then
 echo -e "The script checks if a container is running.\n
        OK       - running
        CRITICAL - container is stopped
        UNKNOWN  - does not exist\n"
 echo "Usage: ./check-container-state.sh <CONTAINER>"
 exit 1
fi

CONTAINER=$1
RUNNING=$(docker inspect -f {{.State.Running}} $CONTAINER 2> /dev/null)

echo "CHECK if container \"$CONTAINER\" is running"

if [ $? -eq 1 ]; then
  echo "UNKNOWN - $CONTAINER does not exist."
  exit 3
fi

if [ "$RUNNING" == "false" ]; then
  echo "CRITICAL - $CONTAINER is not running."
  exit 2
fi

STARTED=$(docker inspect -f {{.State.StartedAt}} $CONTAINER)
NETWORK=$(docker inspect -f {{.NetworkSettings.IPAddress}} $CONTAINER)

echo "OK - $CONTAINER is running. IP: $NETWORK, Started at: $STARTED"