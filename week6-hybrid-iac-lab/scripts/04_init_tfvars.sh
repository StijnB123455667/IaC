#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../terraform"

if [[ -f terraform.tfvars ]]; then
  echo "terraform.tfvars already exists. Not overwriting."
else
  cp terraform.tfvars.example terraform.tfvars
  echo "Created terraform/terraform.tfvars. Open it and fill in:"
  echo "- azure_subscription_id"
  echo "- esxi_password"
fi
