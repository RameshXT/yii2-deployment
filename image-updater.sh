#!/bin/bash

IMAGE_TAG=$1

# IMAGE UPDATER
echo "Updating ecs.tf with the new image tag: $IMAGE_TAG"
sed -i "s|image\s*=\s*\".*\"|image = \"$IMAGE_TAG\"|" docker-compose.yml

echo "ecs.tf file updated successfully with image tag: $IMAGE_TAG"
