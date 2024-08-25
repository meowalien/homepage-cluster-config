#!/bin/bash

minikube start --insecure-registry="docker-registry.docker-registry.svc.cluster.local:5000"
kubectl kubevpn connect -n default

# Install ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Get the initial password for the admin account
argocd admin initial-password -n argocd

argocd login argocd-server.argocd.svc.cluster.local --insecure

argocd account update-password

export CLUSTER_CONFIG_PROJECT_URL=git@github.com:meowalien/homepage-cluster-config.git
argocd repo add $CLUSTER_CONFIG_PROJECT_URL --ssh-private-key-path ~/.ssh/id_rsa

kubectl apply -f ./application.yaml






















