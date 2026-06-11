# Week 2 IaC Lab

Dit project bevat Infrastructure as Code voorbeelden voor week 2 van het IaC lab.

## Projectstructuur

```
week2-iac-lab/
├── opdracht1/                  # Opdracht 1: Single VM deployments
│   ├── esxi-single-vm/        # Single VM op ESXi
│   └── azure-single-vm/       # Single VM op Azure
├── opdracht2/                  # Opdracht 2: Multi-VM deployments
│   ├── esxi-3vms/             # 3 VMs op ESXi (2 webservers + 1 database)
│   └── azure-2vms/            # 2 VMs op Azure
├── docs/                       # Documentatie
│   ├── opdracht3-ontwerptekeningen.md
│   └── opdracht4-terraform-organisatie.md
└── README.md
```

## Getting Started

### Prerequisites

- Terraform >= 1.6.0
- Credentials voor ESXi of Azure (afhankelijk van deployment)
- SSH key pair (ED25519 aanbevolen)

### Deployment

1. Navigeer naar de gewenste directory (bijv. `opdracht1/esxi-single-vm/`)
2. Kopieer `terraform.tfvars.example` naar `terraform.tfvars`
3. Pas de waarden in `terraform.tfvars` aan naar jouw omgeving
4. Run Terraform:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```

## Documentatie

- Zie [opdracht3-ontwerptekeningen.md](docs/opdracht3-ontwerptekeningen.md) voor architectuurdiagrammen
- Zie [opdracht4-terraform-organisatie.md](docs/opdracht4-terraform-organisatie.md) voor projectstructuur details

## Support

Voor vragen of problemen, raadpleeg de documentatie in de `docs/` directory.
