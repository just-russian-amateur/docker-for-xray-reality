#!/bin/bash

set -e

echo ">>> Install Docker..."
# Delete old packages
sudo apt-get remove -y docker docker-engine docker.io containerd runc || true

# Oficial script for install Docker
curl -fsSL https://get.docker.com | sh

# Docker avaliable without sudo (optional)
sudo usermod -aG docker $USER

echo ">>> Install Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" \
  -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo ">>> Cloning the repository with Xray Reality settings..."
if [ ! -d "xray-docker" ]; then
  git clone https://github.com/Alexxxander-Laptev/docker-for-xray-reality.git
fi
cd docker-for-xray-reality

echo ">>> Building and starting container..."
docker compose up -d --build

echo ">>> Get parameters for client..."
sleep 3
docker logs docker-for-xray-reality | tail -n 20

echo ">>> Done! If you just added yourself to the docker group,"
echo ">>> log out and log back in to make the docker command work without sudo."
