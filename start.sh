#!/bin/bash

minikube start --insecure-registry="docker-registry.docker-registry.svc.cluster.local:5000"

kubectl kubevpn connect -n default