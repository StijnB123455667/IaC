instance-id: ${hostname}
local-hostname: ${hostname}
network:
  version: 2
  ethernets:
    ${interface_name}:
      dhcp4: false
      addresses:
        - ${ip_address}/${ip_prefix_length}
      routes:
        - to: default
          via: ${gateway}
      nameservers:
        addresses: [${join(", ", dns_servers)}]
