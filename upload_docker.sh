#!/usr/bin/env bash
# This file tags and uploads an image to Docker Hub
source utils.sh

# Assumes that an image is built via `run_docker.sh`
if [ -z $(image-id) ]; then
    error-exit "No image to upload, have you run `run_docker.sh`?"
fi

# Step 1:
# Create dockerpath
# $dockerpath lives in `utils.sh`

# Step 2:
# Authenticate & tag
echo "Docker ID and Image: $dockerpath"
docker-login
docker tag $(image-id) ${dockerpath}

# Step 3:
# Push image to a docker repository
docker push ${dockerpath}
