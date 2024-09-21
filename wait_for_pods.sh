#!/bin/bash

echo "Waiting for all pods to be ready..."

# wait for apply to finish
sleep 3

prev_total_lines=0

while true; do
    # Get all pods in all namespaces without headers
    pods=$(kubectl get pods --all-namespaces --no-headers)

    # Find pods that are not yet ready
    not_ready_pods=$(echo "$pods" | awk '{split($3, a, "/"); if (a[1] != a[2]) print $0}')

    if [ -z "$not_ready_pods" ]; then
        # Move the cursor up by the number of previous lines
        if [ "$prev_total_lines" -gt 0 ]; then
            printf "\033[%dA" "$prev_total_lines"
        fi
        echo "All pods are ready."
        break
    else
        # Count the number of lines to be printed
        num_pods=$(echo "$not_ready_pods" | wc -l)
        total_lines=$((3 + num_pods))

        # Move the cursor up by the number of previous lines
        if [ "$prev_total_lines" -gt 0 ]; then
            printf "\033[%dA" "$prev_total_lines"
        fi

        # Print the updated status
        echo "Waiting for all pods to be ready..."
        echo "========================================"
        echo "The following pods are not ready yet:"
        echo "$not_ready_pods"

        # Update the previous total lines
        prev_total_lines=$total_lines

        sleep 5
    fi
done