#!/bin/bash

export HTTPS_PROXY=localhost:8888
kubectl port-forward svc/mongo-express-service -n mongo-express 8001:80