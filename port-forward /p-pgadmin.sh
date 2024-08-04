#!/bin/bash
export HTTPS_PROXY=localhost:8888
kubectl port-forward svc/pgadmin -n postgresql 8000:80