#!/bin/bash

# start minikube
minikube start --insecure-registry="docker-registry.docker-registry.svc.cluster.local:5000"

# tunnel to minikube
kubevpn connect -n default

./wait_for_pods.sh

