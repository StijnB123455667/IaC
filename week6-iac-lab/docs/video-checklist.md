# Video checklist week 6

Laat in de video kort zien:

1. De repositorystructuur.
2. `terraform apply` of de Terraform outputs.
3. Het bestand `terraform/generated/inventory.ini`.
4. SSH naar de ESXi VM:

```bash
ssh testuser@<esxi_vm_ip>
```

5. Vanaf de ESXi VM SSH naar Azure:

```bash
ssh azure-vm
```

6. Op de Azure VM:

```bash
whoami
hostname
docker ps
```

7. Terug naar de ESXi VM en daar ook:

```bash
docker ps
```

8. Test eventueel de container:

```bash
curl http://<azure_public_ip>
curl http://<esxi_vm_ip>
```
