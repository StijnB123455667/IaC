# Week 5 - IaC Lab

Deze repository bevat de uitwerking van week 5 voor Infrastructure as Code.

## Inhoud

```text
.
├── .github/workflows/
│   ├── ansible-ci-cd.yml
│   ├── terraform-ci-cd.yml
│   └── terraform-destroy.yml
├── ansible/
│   ├── ansible.cfg
│   ├── install-apache-with-command.yml
│   ├── install-package.yml
│   └── inventory/hosts.ini
├── terraform/
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── versions.tf
├── docs/
│   └── opdracht4-cicd-organisatie.md
├── .gitignore
└── README.md
```

## Opdracht 1

Playbook:

```bash
ansible-playbook ansible/install-apache-with-command.yml
```

In dit playbook wordt `apache2` geinstalleerd zonder de Ansible `apt` module. Hiervoor wordt `ansible.builtin.command` gebruikt met `apt-get install -y apache2`.

Er is ook een bewuste fout toegevoegd met `/bin/false`, zodat Ansible duidelijk laat zien dat een taak gefaald heeft.

## Opdracht 2

Er is een lokale GitHub Runner nodig. Deze workflow gebruikt daarom:

```yaml
runs-on: self-hosted
```

Workflow:

```text
.github/workflows/ansible-ci-cd.yml
```

Stages:

1. `lint` - controleert Ansible code met ansible-lint
2. `syntax-check` - controleert de syntax van het playbook
3. `deploy` - draait het playbook automatisch bij push

De workflow draait alleen wanneer bestanden in `ansible/**` of de workflow zelf wijzigen.

## Lokale GitHub Runner toevoegen

Ga in GitHub naar:

```text
Repository > Settings > Actions > Runners > New self-hosted runner
```

Kies Linux en voer de commands uit die GitHub toont. Start daarna de runner met:

```bash
./run.sh
```

## Opdracht 3

Terraform manifest:

```text
terraform/main.tf
```

Workflow:

```text
.github/workflows/terraform-ci-cd.yml
```

Stages:

1. `validate` - terraform fmt, init en validate
2. `best-practices` - tflint controle
3. `plan` - terraform plan
4. `apply` - terraform apply op main

De workflow draait alleen wanneer bestanden in `terraform/**` of de workflow zelf wijzigen.

## Terraform destroy

Voor het verwijderen van infrastructuur is een aparte workflow gemaakt:

```text
.github/workflows/terraform-destroy.yml
```

Deze workflow draait alleen handmatig via `workflow_dispatch`.

## Benodigde GitHub Secrets

Voor Azure Terraform zijn deze secrets nodig:

```text
ARM_CLIENT_ID
ARM_CLIENT_SECRET
ARM_SUBSCRIPTION_ID
ARM_TENANT_ID
TF_VAR_SSH_PUBLIC_KEY
```

## Opdracht 4

De uitwerking staat in:

```text
docs/opdracht4-cicd-organisatie.md
```
