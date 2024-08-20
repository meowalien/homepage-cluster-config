#!/bin/bash

# Function to clean up background processes
cleanup() {
  echo "Cleaning up..."
  pkill -P $$
}

# Trap EXIT signal to run cleanup function
trap cleanup EXIT


echo "Creating SSH tunnel to bastion-vm..."
kill -9 $(lsof -ti:8888 -sTCP:LISTEN) 2>/dev/null
gcloud compute ssh bastion-vm \
    --tunnel-through-iap \
    -- -L 8888:localhost:8888 -N -q -f

export HTTPS_PROXY=localhost:8888

echo "Creating SSH tunnel to sshd service..."
# Run kubectl port-forward in the background
kubectl port-forward svc/sshd -n sshd 2222:22 &

echo "Waiting for port 2222 to be available..."
# Wait for port 2222 to be available
while ! nc -z localhost 2222; do
  sleep 1
done

echo "sshuttle to cluster network..."
# Run sshuttle once port 2222 is available
sshuttle --dns -r tunnel@localhost:2222 34.118.224.0/20 10.53.0.0/17 192.168.0.0/20 &
# 192.168.0.0/20
# Wait for all background processes to finish
wait