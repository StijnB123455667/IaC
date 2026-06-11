#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

ansible-galaxy collection install -r ansible/requirements.yml
ansible -i terraform/generated/inventory.ini all -m ping
ansible-playbook -i terraform/generated/inventory.ini ansible/playbooks/site.yml
