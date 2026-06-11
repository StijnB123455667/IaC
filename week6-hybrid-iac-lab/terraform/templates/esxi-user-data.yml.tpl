#cloud-config
package_update: true
packages:
  - wget
  - curl
  - ntpdate
  - python3
  - python3-apt
  - ca-certificates
  - gnupg
  - lsb-release

users:
  - name: ${username}
    groups: sudo
    shell: /bin/bash
    sudo: ALL=(ALL) NOPASSWD:ALL
    ssh_authorized_keys:
      - ${ssh_public_key}

write_files:
  - path: /home/${username}/hello.txt
    owner: ${username}:${username}
    permissions: '0644'
    content: |
      Hello from ESXi VM

runcmd:
  - chown -R ${username}:${username} /home/${username}
