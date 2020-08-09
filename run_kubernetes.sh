#!/usr/bin/env bash
source utils.sh

# Step 1
# Run the Docker Hub container with kubernetes
echo "Creating kubernetes service/pod $PROJECT"
kubectl run $PROJECT \
    --generator=run-pod/v1 \
    --image=$dockerpath \
    --port=$APP_PORT --labels app=$PROJECT \
    --expose

# Step 2:
# List kubernetes pods
kubectl get pods
POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME

# Wait for pod to be up
echo "Waiting for $POD_NAME to be Ready"
kubectl wait --for=condition=Ready pod/$POD_NAME

# Step 3:
# Forward the container port to host
echo "Forwarding application port $APP_PORT --> $SERVICE_PORT"
kubectl port-forward $PROJECT $SERVICE_PORT:$APP_PORT
