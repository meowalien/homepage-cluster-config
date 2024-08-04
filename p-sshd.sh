#!/bin/bash

export HTTPS_PROXY=localhost:8888
kubectl port-forward svc/sshd -n sshd 2222:22
