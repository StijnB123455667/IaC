# Opdracht 4: Terraform Organisatie

Dit document beschrijft de Terraform projectstructuur en best practices.

## Structuur

Het project is georganiseerd in de volgende structuur:

```
week2-iac-lab/
├── opdracht1/         # Single VM deployments
│   ├── esxi-single-vm/   # ESXi single VM setup
│   └── azure-single-vm/  # Azure single VM setup
├── opdracht2/         # Multi-VM deployments
│   ├── esxi-3vms/        # ESXi 3 VMs setup (2 webservers + 1 database)
│   └── azure-2vms/       # Azure 2 VMs setup
└── docs/              # Documentatie
```

## Bestanden

Elke Terraform directory bevat:

- `versions.tf` - Terraform version requirements en provider versioning
- `variables.tf` - Input variables
- `provider.tf` - Provider configuratie
- `main.tf` - Resource definitions
- `outputs.tf` - Output values
- `terraform.tfvars.example` - Example values (kopieer naar terraform.tfvars)

## Cloud-Init

Cloud-init templates bevinden zich in de `cloud-init/` subdirectory:
- `user-data.yml.tpl` - User data configuration
- `meta-data.yml.tpl` - Meta data configuration

