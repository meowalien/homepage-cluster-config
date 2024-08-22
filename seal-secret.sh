#!/bin/bash

# Define variables for kubeseal
#PROXY_URL="http://localhost:8888"
CONTROLLER_NAMESPACE="sealed-secrets"

# Pipe the input to kubeseal
kubeseal --format yaml --controller-namespace $CONTROLLER_NAMESPACE