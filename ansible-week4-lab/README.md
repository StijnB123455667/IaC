# Ansible Week 4 Lab

Deze repository bevat de uitwerking van de week 4 Ansible labopdracht.

## Inhoud

- Inventory met webserver en database server
- Role `webserver` voor Apache, PHP en php-mysql
- Role `database` voor MySQL en databasegebruiker
- Handlers en variabelen
- `group_vars` per servergroep
- Playbook voor lokale roles
- Voorbeeldplaybook voor Galaxy/GitHub roles
- Markdown-uitwerking over inzet van roles in een organisatie

## Inventory

De inventory staat in `inventory/hosts.ini`.

Pas de IP-adressen aan als je echte VM's gebruikt:

```ini
web01 ansible_host=192.168.56.10 ansible_user=ubuntu server_role=webserver
db01 ansible_host=192.168.56.11 ansible_user=ubuntu server_role=database
```

## Benodigdheden installeren

```bash
ansible-galaxy collection install -r requirements.yml
```

## Playbook uitvoeren

```bash
ansible-playbook site.yml
```

## MySQL login

Na uitvoering bestaat de gebruiker:

- username: `dbuser`
- password: `dbpassword`
- database: `labdb`

Voorbeeld:

```bash
mysql -u dbuser -pdbpassword -h 192.168.56.11 labdb
```

## Ansible Galaxy

Ansible Galaxy is een platform en command-line tool om Ansible roles en collections te delen, downloaden en hergebruiken. Rollen kunnen via `requirements.yml` worden geïnstalleerd met:

```bash
ansible-galaxy install -r requirements.yml
```

Voor opdracht 2 kun je per role een aparte GitHub repository maken, bijvoorbeeld:

- `ansible-role-webserver`
- `ansible-role-database`

Daarna kun je de role importeren in Ansible Galaxy of direct vanuit GitHub gebruiken.

## Opdracht 3

Voor samenwerking met een medestudent kun je diens role toevoegen aan `requirements.yml` en gebruiken in `student-role-playbook.yml`.

Voorbeeld:

```yaml
roles:
  - name: klasgenoot.webserver
    src: https://github.com/gebruikersnaam/ansible-role-webserver.git
    scm: git
    version: main
```
