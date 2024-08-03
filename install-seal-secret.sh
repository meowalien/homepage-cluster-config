#!/bin/bash

# Check if the first argument is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <CONTROLLER_NAMESPACE>"
  exit 1
fi

# Define variables for kubeseal
CONTROLLER_NAMESPACE="$1"

export HTTPS_PROXY=localhost:8888
helm install sealed-secrets -n "$CONTROLLER_NAMESPACE" --set-string fullnameOverride=sealed-secrets-controller ./sealed-secrets