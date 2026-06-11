#!/usr/bin/env bash
set -euo pipefail

IMAGE_DIR="${HOME}/iac/images"
OVA_URL="https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.ova"
OVA_PATH="${IMAGE_DIR}/noble-server-cloudimg-amd64.ova"

mkdir -p "${IMAGE_DIR}"

if [[ -f "${OVA_PATH}" ]]; then
  echo "OVA already exists: ${OVA_PATH}"
else
  echo "Downloading Ubuntu 24.04 cloud image OVA..."
  wget -O "${OVA_PATH}" "${OVA_URL}"
fi

ls -lh "${OVA_PATH}"
