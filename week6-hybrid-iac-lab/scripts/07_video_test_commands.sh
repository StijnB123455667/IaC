#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../terraform"

AZURE_IP="$(cat generated/azure_ip.txt)"
ESXI_IP="$(cat generated/esxi_ip.txt)"

echo "Azure IP: ${AZURE_IP}"
echo "ESXi VM IP: ${ESXI_IP}"
echo
echo "Run these commands for the video:"
echo "ssh testuser@${ESXI_IP}"
echo "whoami && hostname"
echo "ssh azure-vm"
echo "whoami && hostname"
echo "docker ps"
echo "exit"
echo "exit"
echo "curl http://${AZURE_IP}"
echo "curl http://${ESXI_IP}"
