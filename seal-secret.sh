#!/bin/bash

# Define variables for kubeseal
CONTROLLER_NAMESPACE="sealed-secrets"

# -n flag to specify the namespace
# -f flag to specify the file path
while getopts "n:f:" opt; do
  case $opt in
    n) NAMESPACE=$OPTARG ;;
    f) FILE_PATH=$OPTARG ;;
    \?) echo "Invalid option: $OPTARG" ;;
  esac
done

# Shift to get the public-key argument
shift $((OPTIND - 1))
NAME=$1

# Check if both NAMESPACE, FILE_PATH, and NAME are set
if [ -z "$NAMESPACE" ] || [ -z "$FILE_PATH" ] || [ -z "$NAME" ]; then
  echo "Error: -n (namespace), -f (file path) flags and public-key argument are required."
  exit 1
fi

FILE_NAME=$(basename "$FILE_PATH")



echo "Sealing $FILE_PATH ($FILE_NAME) in namespace $NAMESPACE with name: $NAME"

# Pipe the input to kubeseal
kubectl create secret generic "$NAME" -n "$NAMESPACE" --from-file="$FILE_NAME"="$FILE_PATH" -o yaml --dry-run=client \
 | kubeseal --format yaml --controller-namespace $CONTROLLER_NAMESPACE > "$NAME".yaml