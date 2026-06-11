%{ if deploy_azure ~}
[azure]
azure-vm ansible_host=${azure_ip} ansible_user=${admin_username}
%{ endif ~}

%{ if deploy_esxi ~}
[esxi]
esxi-vm ansible_host=${esxi_ip} ansible_user=${admin_username}
%{ endif ~}

[hybrid:children]
%{ if deploy_azure ~}
azure
%{ endif ~}
%{ if deploy_esxi ~}
esxi
%{ endif ~}

[all:vars]
ansible_python_interpreter=/usr/bin/python3
ansible_ssh_private_key_file=~/.ssh/week6_testuser_ed25519
