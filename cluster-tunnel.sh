#!/bin/bash


# Kill existing SSH tunnels on the same local port if it exist
kill $(lsof -ti:8888 -sTCP:LISTEN) 2>/dev/null

# Create a tunnel to my cluster on localhost:8888
gcloud compute ssh bastion-vm \
    --tunnel-through-iap \
    -- -L 8888:localhost:8888 -N -q -f

./proxy.sh