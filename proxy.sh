#!/bin/bash

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
