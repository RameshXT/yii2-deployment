#!/bin/bash

# Exit on error
set -e

IMAGE_TAG="$1"

# Validate input
if [[ -z "$IMAGE_TAG" ]]; then
  echo "Error: No image tag provided."
  echo "Usage: $0 <image-tag>"
  exit 1
fi

FILE="docker-compose.yml"

# Check if the file exists
if [[ ! -f "$FILE" ]]; then
  echo "Error: File $FILE not found."
  exit 1
fi

# Update the image tag in the file
echo "Updating $FILE with new image tag: $IMAGE_TAG"
sed -i.bak "s|image: .*|image: $IMAGE_TAG|" "$FILE"

echo "$FILE updated successfully with image tag: $IMAGE_TAG"
