#!/usr/bin/env bash
set -euo pipefail

ESXI_IP="${1:-192.168.1.114}"

echo "Pinging ESXi host: ${ESXI_IP}"
ping -c 3 "${ESXI_IP}"

echo
echo "Checking ESXi HTTPS endpoint: https://${ESXI_IP}"
curl -k -I "https://${ESXI_IP}" || true

echo
echo "If this worked, your control machine can reach ESXi."
