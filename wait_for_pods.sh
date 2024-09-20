#!/bin/bash

echo "Waiting for all pods to be ready..."

while true; do
    # Get all pods in all namespaces without headers
    pods=$(kubectl get pods --all-namespaces --no-headers)

    # Find pods that are not yet ready
    not_ready_pods=$(echo "$pods" | awk '{split($3, a, "/"); if (a[1] != a[2]) print $0}')

    if [ -z "$not_ready_pods" ]; then
        echo "All pods are ready."
        break
    else
        # Clear the console output
        clear
        echo "Waiting for all pods to be ready..."
        echo "========================================"
        echo "The following pods are not ready yet:"
        echo "$not_ready_pods"
        sleep 5
    fi
done