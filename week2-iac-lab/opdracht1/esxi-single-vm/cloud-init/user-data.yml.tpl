#cloud-config
package_update: true
package_upgrade: false

users:
  - default
  - name: ${admin_username}
    gecos: IaC User
    groups: sudo
    shell: /bin/bash
    lock_passwd: true
    sudo: "ALL=(ALL) NOPASSWD:ALL"
    ssh_authorized_keys:
      - ${ssh_public_key}

ssh_pwauth: false
packages:
  - wget
  - ntpdate

runcmd:
  - [ cloud-init-per, once, confirm-packages, bash, -lc, "dpkg -l wget ntpdate >/var/log/iac-package-check.log 2>&1" ]
