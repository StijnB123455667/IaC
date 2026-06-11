#!/usr/bin/env bash
set -euo pipefail

commands=(terraform ansible az git ssh ovftool)

for cmd in "${commands[@]}"; do
  if command -v "$cmd" >/dev/null 2>&1; then
    echo "OK: $cmd -> $(command -v "$cmd")"
  else
    echo "MISSING: $cmd"
  fi
done

echo
cat <<'MSG'
Notes:
- Terraform, Ansible, Azure CLI, Git and SSH are required on the Ubuntu Desktop control machine.
- ovftool is required by the josenk/esxi Terraform provider when importing an OVA to ESXi.
- ESXi SSH must be enabled on the ESXi host.
MSG
