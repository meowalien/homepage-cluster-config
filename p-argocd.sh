#!/bin/bash

export HTTPS_PROXY=localhost:8888
kubectl port-forward svc/argocd-server -n argocd 8080:443