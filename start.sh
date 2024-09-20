#!/bin/bash

# start minikube
minikube start --insecure-registry="docker-registry.docker-registry.svc.cluster.local:5000"

# tunnel to minikube
kubevpn connect -n default

./wait_for_pods.sh

# Install ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

./wait_for_pods.sh

# Extract the first line which contains the password
ARGOCD_INITIAL_PASSWORD=$(echo "$(argocd admin initial-password -n argocd)" | head -n 1)

argocd login argocd-server.argocd.svc.cluster.local --insecure --username admin --password "$ARGOCD_INITIAL_PASSWORD"

ARGOCD_PASSWORD=password
# Update the password
argocd account update-password --account admin --current-password "$ARGOCD_INITIAL_PASSWORD" --new-password "$ARGOCD_PASSWORD"

# Create the docker registry
kubectl apply -f ./docker-registry.yaml