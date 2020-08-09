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

```

## Requirements

The project was developed and tested on OSX using [docker desktop for Mac](https://docs.docker.com/docker-for-mac/install/) which includes Kubernetes (minikube).

Follow [this guide](https://docs.docker.com/docker-for-mac/install/) to setup the local kubernetes cluster on your Mac.

## Setup the Environment

* Create a virtualenv with `make venv`. 
You can select where to install the virtualenv by passing the environment variable `VENV`
* You can (optionally) activate it as suggested
* Run `make install` to install the necessary dependencies

### Running `app.py`

1. Standalone:  `python app.py`
2. Run in Docker:  `./run_docker.sh`
3. Run in Kubernetes:  `./run_kubernetes.sh`

### Kubernetes Steps

* Setup and Configure Docker locally.
* Setup and Configure Kubernetes locally
* Create Flask app in Container
* Run via kubectl

## Running the example

### Task 2: Run container

```
run_docker.sh
make_prediction.sh
docker logs $(container-id)
```

### Task 3: Improve logging and save output

Kill your running container:

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

### Task 4: Upload docker image

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

### Task 6: Deploy with Kubernetes and Save Output Logs


