#!/bin/bash

# Install ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# wait for apply to finish
sleep 1

./wait_for_pods.sh

# Extract the first line which contains the password
ARGOCD_INITIAL_PASSWORD=$(echo "$(argocd admin initial-password -n argocd)" | head -n 1)

argocd login argocd-server.argocd.svc.cluster.local --insecure --username admin --password "$ARGOCD_INITIAL_PASSWORD"

ARGOCD_PASSWORD=password
# Update the password
argocd account update-password --account admin --current-password "$ARGOCD_INITIAL_PASSWORD" --new-password "$ARGOCD_PASSWORD"

# install the dependencies
kubectl apply -f ./dependencies.yaml

# wait for apply to finish
sleep 1

./wait_for_pods.sh