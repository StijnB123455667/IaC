#!/usr/bin/env bash
set -euo pipefail

KEY_PATH="${HOME}/.ssh/week6_testuser_ed25519"

mkdir -p "${HOME}/.ssh"
chmod 700 "${HOME}/.ssh"

if [[ -f "${KEY_PATH}" ]]; then
  echo "SSH key already exists: ${KEY_PATH}"
else
  ssh-keygen -t ed25519 -f "${KEY_PATH}" -C "week6-testuser" -N ""
fi

echo "Public key:"
cat "${KEY_PATH}.pub"
