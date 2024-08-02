#!/bin/bash

# Define variables for kubeseal
PROXY_URL="http://localhost:8888"
CONTROLLER_NAMESPACE="homepage"

# Pipe the input to kubeseal
kubeseal --format yaml --proxy-url $PROXY_URL --controller-namespace $CONTROLLER_NAMESPACE