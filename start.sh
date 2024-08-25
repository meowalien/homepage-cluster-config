#!/bin/bash

#minikube start

#minikube ssh -- "sudo sed -i '0,/{/s/{/{\"insecure-registries\": [\"docker-registry.docker-registry.svc.cluster.local:5000\"],/' /etc/docker/daemon.json"

kubectl kubevpn connect -n default