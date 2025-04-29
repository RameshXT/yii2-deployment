#!/bin/bash

IMAGE_TAG=$1

# IMAGE UPDATER
echo "Updating Docker-stack.yml with the new image tag: $IMAGE_TAG"
sed -i "s|image\s*=\s*\"[^\"]*\"|image = \"$IMAGE_TAG\"|" Docker-stack.yml

echo "Docker-stack.yml file updated successfully with image tag: $IMAGE_TAG"
