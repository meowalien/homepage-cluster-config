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


# unset helm if it exist
unset -f helm 2>/dev/null

helm() {
  HTTPS_PROXY=localhost:8888 command helm "$@"
}

## unset kubeseal if it exist
#unset -f kubeseal 2>/dev/null
#
#kubeseal() {
#  HTTPS_PROXY=localhost:8888 command kubeseal "$@"
#}