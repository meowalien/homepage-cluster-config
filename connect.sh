#!/bin/bash

# Function to clean up background processes
cleanup() {
  echo "Cleaning up..."
  pkill -P $$
}

# Trap EXIT signal to run cleanup function
trap cleanup EXIT

# Run kubectl port-forward in the background
HTTPS_PROXY=localhost:8888 kubectl port-forward svc/sshd -n sshd 2222:22 &

# Wait for port 2222 to be available
while ! nc -z localhost 2222; do
  sleep 1
done

# Run sshuttle once port 2222 is available
sshuttle --dns -r tunnel@localhost:2222 34.118.224.0/20 10.53.0.0/17 192.168.0.0/20 &

# Wait for all background processes to finish
wait