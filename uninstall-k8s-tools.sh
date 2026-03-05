#!/bin/bash

echo "🧹 Cleaning up Kubernetes GitOps toolkit..."

# 1. Destroy any existing local clusters
if command -v kind &>/dev/null; then
    echo "🔥 Destroying kind clusters (requires sudo for rootful clusters)..."
    sudo kind delete cluster --all
    kind delete cluster --all 2>/dev/null || true
fi

# 2. Remove the packages via DNF
echo "🗑️ Removing packages via dnf..."
sudo dnf remove -y kind kubernetes1.35-client helm k9s

# 3. Clean up local configuration directories
echo "🧹 Removing local config directories (~/.kube, ~/.helm)..."
rm -rf ~/.kube
rm -rf ~/.helm
rm -rf ~/.config/helm
rm -rf ~/.cache/helm

echo "✅ Environment successfully restored to its previous state!"
