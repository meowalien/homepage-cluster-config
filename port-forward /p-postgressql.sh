#!/bin/bash
export HTTPS_PROXY=localhost:8888
kubectl port-forward svc/postgres -n postgresql 5432:5432