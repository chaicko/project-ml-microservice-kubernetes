#!/usr/bin/env bash
source ./project.conf

# Step 1:
# Build image and add a descriptive tag
docker build -t $PROJECT .

# Step 2:
# List docker images
docker image ls

# Step 3:
# Run flask app
docker run -d -p $HOST_PORT:$CONTAINER_PORT $PROJECT
