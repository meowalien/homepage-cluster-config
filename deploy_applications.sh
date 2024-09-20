#!/bin/bash


# install the dependencies
kubectl apply -f ./application.yaml

./wait_for_pods.sh