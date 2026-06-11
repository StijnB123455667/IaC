# Week 6 - Hybrid Cloud IaC Deployment

Deze repository is een starter-template voor de week 6 eindopdracht.

Doel:

- Terraform maakt 1 Azure VM.
- Terraform maakt 1 ESXi VM.
- Op beide VM's bestaat gebruiker `testuser`.
- Ansible automatiseert SSH van de ESXi VM naar de Azure VM.
- Ansible installeert Docker via een zelfgemaakte Galaxy-ready role.
- Een Hello World Docker container draait op beide systemen.
- GitHub Actions kan de Docker image bouwen en later de deployment uitvoeren via een self-hosted runner.

## Jouw labomgeving

Bestaand:

- ESXi server: `192.168.1.114`
- ESXi datastore: `Storage01`
- ESXi portgroup: `VM Network`
- Ubuntu Desktop: control machine
- Ubuntu Server: optioneel als self-hosted GitHub runner

Wordt aangemaakt:

- `week6-esxi-vm` op ESXi
- `week6-azure-vm` in Azure

## Precondities op de Ubuntu Desktop control machine

Controleer:

```bash
terraform -version
ansible --version
az version
git --version
ssh -V
ovftool --version
```

Let op: de ESXi Terraform provider gebruikt `ovftool` voor het importeren van OVA's. Installeer VMware OVF Tool handmatig als `ovftool` ontbreekt.

Ook moet SSH op de ESXi host aanstaan.

## Stappenplan

### 1. Control machine controleren

```bash
./scripts/00_check_control_machine.sh
```

### 2. SSH key maken

```bash
./scripts/01_prepare_ssh_key.sh
```

Dit maakt:

```text
~/.ssh/week6_testuser_ed25519
~/.ssh/week6_testuser_ed25519.pub
```

### 3. Ubuntu 24.04 cloud image downloaden

```bash
./scripts/02_download_ubuntu_ova.sh
```

Dit downloadt de OVA naar:

```text
/home/student/iac/images/noble-server-cloudimg-amd64.ova
```

### 4. ESXi bereikbaarheid testen

```bash
./scripts/03_check_esxi.sh 192.168.1.114
```

### 5. terraform.tfvars maken

```bash
./scripts/04_init_tfvars.sh
```

Open daarna:

```text
terraform/terraform.tfvars
```

Vul minimaal in:

- `azure_subscription_id`
- `esxi_password`

Commit `terraform.tfvars` nooit naar GitHub.

### 6. Azure login controleren

```bash
az login
az account show --query "{name:name,id:id,user:user.name}" -o table
```

### 7. Terraform uitvoeren

```bash
./scripts/05_terraform_apply.sh
```

Terraform maakt daarna onder andere:

```text
terraform/generated/inventory.ini
terraform/generated/azure_ip.txt
terraform/generated/esxi_ip.txt
```

### 8. SSH testen vanaf control machine

```bash
ssh testuser@$(cat terraform/generated/azure_ip.txt)
ssh testuser@$(cat terraform/generated/esxi_ip.txt)
```

### 9. Ansible uitvoeren

```bash
./scripts/06_run_ansible.sh
```

Dit doet:

- Docker installeren op beide VM's
- Hello World container starten op beide VM's
- Private key en SSH config op de ESXi VM plaatsen
- SSH alias `azure-vm` maken op de ESXi VM

### 10. Video-test uitvoeren

Toon deze flow in je video:

```bash
ssh testuser@<esxi_vm_ip>
whoami
hostname
ssh azure-vm
whoami
hostname
docker ps
```

Handig commando:

```bash
./scripts/07_video_test_commands.sh
```

## Docker image

Standaard gebruikt Ansible tijdelijk:

```text
nginx:alpine
```

Voor de eindversie moet je je eigen CI/CD image gebruiken. De workflow `.github/workflows/docker-build.yml` bouwt en pusht:

```text
ghcr.io/<jouw-github-naam>/week6-hello:latest
```

Pas daarna aan in:

```text
ansible/group_vars/all.yml
```

Bijvoorbeeld:

```yaml
container_image: ghcr.io/jouw-github-naam/week6-hello:latest
```

## Ansible Galaxy role

De Docker role staat in:

```text
ansible/roles/iac_docker
```

Deze role is Galaxy-ready gemaakt met een `meta/main.yml`. Voor de echte Galaxy-stap kun je deze role later naar een eigen GitHub repository kopieren en importeren in Ansible Galaxy. Daarna pas je `ansible/requirements.yml` aan naar jouw namespace.

## Belangrijke security-opmerking

Voor deze schoolopdracht wordt de private key automatisch naar de ESXi VM gekopieerd, zodat `testuser` vanaf de ESXi VM naar de Azure VM kan SSH'en. Dat is handig voor het lab en voor de video. In een productieomgeving zou je dit strenger beveiligen met bijvoorbeeld tijdelijke credentials, Vault of een bastion-oplossing.
