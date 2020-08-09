#!/usr/bin/env bash
source project.conf

# Print the id (hash) of the $PROJECT container image
image-id () {
    local id=$(docker images $PROJECT --format "{{.ID}}")
    echo "$id"
}

# Print the running container id (hash) of our $PROJECT
container-id () {
    local id=$(docker container ls --filter status=running --filter ancestor=$PROJECT --format "{{.ID}}")
    echo "$id"
}

# Post a prediction request to our running service
predict () {
    # POST method predict
    local JSON=$(cat <<-EOF
{
   "CHAS":{
      "0":$1
   },
   "RM":{
      "0":$2
   },
   "TAX":{
      "0":$3
   },
   "PTRATIO":{
      "0":$4
   },
   "B":{
      "0":$5
   },
   "LSTAT":{
      "0":$6
   }
}
EOF
)
    curl -d "$JSON" \
         -H "Content-Type: application/json" \
         -X POST http://localhost:$SERVICE_PORT/predict
}

# Retrieve the docker username from the credentials file
docker-user () {
    local USER=$(jq -r '.["docker"] | .["user"]' $CREDENTIALS)
    echo $USER
}

# Retrieve the docker password from the credentials file
docker-passwd () {
    local PWD=$(jq -r '.["docker"] | .["password"]' $CREDENTIALS)
    echo $PWD
}

# Login to docker
docker-login () {
    local USR=$(docker-user)
    local PWD=$(docker-passwd)
    local OPT=""
    if [ -n ${USR} ]; then OPT+="-u ${USR}"; fi
    if [ -n ${PWD} ]; then
        echo "${PWD}" |  docker login --password-stdin ${OPT}
    else
        docker login $OPT
    fi
}

# docker repository path
dockerpath="$(docker-user)/${PROJECT}"

# Print argument to stderr and exit with error status of 1
error-exit () {
    echo "${1}" 1>&2
    exit 1
}



