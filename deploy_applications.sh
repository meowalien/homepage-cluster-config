#!/bin/bash


# install the dependencies
kubectl apply -f ./application.yaml

# wait for apply to finish
sleep 1

./wait_for_pods.sh