#!/bin/bash
set -e

echo "🚀 Starting installation of Kubernetes local GitOps toolkit..."

echo "📦 Installing dependencies..."
sudo dnf config-manager addrepo --from-repofile="https://download.docker.com/linux/fedora/docker-ce.repo"
# Thirs replaces runc with containerd.io
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

eecho "🔧 Enabling and starting Docker service..."
sudo systemctl enable --now docker

# Install kind, kubectl, and helm directly via DNF
echo "📦 Installing kind, kubernetes-client (kubectl), and helm..."
# Downloading kind binary directly since DNF package has old dependency issues with docker packages
curl -Lo ./kind "https://kind.sigs.k8s.io/dl/v0.31.0/kind-linux-amd64"
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
sudo dnf install -y kubernetes1.35-client helm k9s

# Grant Your User Permissions
# To avoid typing sudo for every Docker and Kind command, add your current user to the docker group:
sudo usermod -aG docker "$USER"
#Important: For this group change to take effect immediately in your current terminal, run:
newgrp docker

echo "✅ Installation complete!"
echo "Versions installed:"
kubectl version --client --output=yaml | grep gitVersion
kind version
helm version --short
