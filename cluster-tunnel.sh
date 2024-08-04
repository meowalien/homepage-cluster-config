#!/bin/bash


# Kill existing SSH tunnels on the same local port if it exist
kill $(lsof -ti:8888 -sTCP:LISTEN) 2>/dev/null

# Create a tunnel to my cluster on localhost:8888
gcloud compute ssh bastion-vm \
    --tunnel-through-iap \
    -- -L 8888:localhost:8888 -N -q -f

# unset kubectl if it exist
unset -f kubectl 2>/dev/null

kubectl() {
  HTTPS_PROXY=localhost:8888 command kubectl "$@"
}

# unset argocd if it exist
unset -f argocd 2>/dev/null

argocd() {
  HTTPS_PROXY=localhost:8888 command argocd "$@"
}


# unset helm if it exist
unset -f helm 2>/dev/null

helm() {
  HTTPS_PROXY=localhost:8888 command helm "$@"
}