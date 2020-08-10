[![chaicko](https://circleci.com/gh/chaicko/project-ml-microservice-kubernetes.svg?style=svg)](https://circleci.com/gh/chaicko/project-ml-microservice-kubernetes)

# project-ml-microservice-kubernetes

Project solution for the Udacity course on Operationalizing a ML Microservice.

## Project Overview

This project includes a a pre-trained, `sklearn` model that has been trained to predict housing prices in Boston according to several features, such as average rooms in a home and data about highway access, teacher-to-pupil ratios, and so on. You can read more about the data, which was initially taken from Kaggle, on [the data source site](https://www.kaggle.com/c/boston-housing). 

The project runs a Python flask app—in a provided file, `app.py`—that serves out predictions (inference) about housing prices through API calls. This project could be extended to any pre-trained machine learning model, such as those for image recognition and data labeling.

---

## Project contents

The following files are part of the project:

```
$ tree -L 1
.
├── Dockerfile: dockerfile to build the container
├── LICENSE: project license
├── Makefile: makefile with workflow tasks
├── README.md: the file you are reading now
├── app.py: the Flask application with the web app
├── dev-requirements.txt: python requirements file used for development
├── make_prediction.sh: utility script that queries the API
├── model_data: directory with the trained ML model data
├── output_txt_files: output log files required by the project
├── project.json: main project configuration
├── project.conf: shell version of the previous file
├── requirements.txt: python requirement libs for the production app
├── run_docker.sh: script that (builds) and runs the application in a docker container
├── run_kubernetes.sh: script that runs
├── tests: directory with tests
├── upload_docker.sh: script to upload image to docker hub
└── utils.sh: bash utilities used throughout the project
```

## Requirements

The project was developed and tested on OSX using [docker desktop for Mac](https://docs.docker.com/docker-for-mac/install/) which includes Kubernetes (minikube).

Follow [this guide](https://docs.docker.com/docker-for-mac/install/) to setup the local kubernetes cluster on your Mac.

## Setup the Environment

1. Create a virtualenv and install all tools with `make install`.
You can select where to install the virtualenv by passing the environment variable `VENV`, like `VENV=~/.myvenv make install`. The default directory for the virtualenv is `./.venv`.

Hadolint is also installed in `./.venv/bin/hadolint`.

You can (optionally) activate it as suggested (not needed):

```
source ./.venv/bin/activate
```

2. Run `make test` to run some tests
3. Run `make lint` for linting

### Running `app.py`

1. Standalone:  `$VENV/bin/python app.py` (where `$VENV=./.venv` as default)
2. Run in Docker:  `./run_docker.sh`
3. Run in Kubernetes:  `./run_kubernetes.sh`

## Project tasks

First `source utils.sh` in order to have some functions available throughout the example.

### Run container

To run the application in a docker container, make a prediction and see the logs run:

```
source ./utils.sh

./run_docker.sh
./make_prediction.sh
docker logs $(container-id)
```

### Improve logging and save output

First kill the running container with:

```
docker container kill $(container-id)
```

Edit `app.py` with more logging output, then re-run (and rebuild) your container:

```
./run_docker.sh
```

Make a prediction and collect the logs:

```
./make_prediction.sh
docker logs $(container-id) > output_txt_files/docker_out.txt 2>&1
```

### Upload docker image

The docker image is uploaded with the `upload_docker.sh` script to [docker hub](https://hub.docker.com/).
You can provide the `docker login` credentials by creating a `credentials.json` file with the following contents:

```
{
  "docker": {
    "user" : "your-username",
    "password": "your-super-secret-password"
  }
}
```

The keys of the dictionary need to be as above. If you don't provide a password then the `docker login` will ask for it. Note that this file is **NOT** part of the project, and ignored.

### Deploy with Kubernetes and Save Output Logs

If you have Kubernetes properly setup and uploaded to docker hub, then simply run `./run_kubernetes.sh`.
