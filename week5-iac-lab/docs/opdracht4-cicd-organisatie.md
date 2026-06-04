# Opdracht 4 - CI/CD in de organisatie

## Situatie
Binnen een organisatie kan CI/CD worden ingezet om infrastructuur en applicatieconfiguratie automatisch te controleren en uit te rollen. Een voorbeeld is een IT-afdeling die webservers, monitoringsoftware of standaard packages op servers beheert.

## Omgeving
De omgeving bestaat uit:

- GitHub als centrale repository
- Een lokale GitHub Runner binnen het bedrijfsnetwerk
- Ansible voor serverconfiguratie
- Terraform voor infrastructuur
- Azure als cloudomgeving

## Wat moet het doen?
De CI/CD-pipeline moet automatisch starten wanneer code naar GitHub wordt gepusht. Voor Ansible controleert de pipeline eerst de syntax en kwaliteit van de playbooks. Daarna kan het playbook automatisch een package installeren, bijvoorbeeld nginx of apache2.

Voor Terraform controleert de pipeline eerst of de code netjes geformatteerd is en valide is. Daarna wordt met een linter gecontroleerd of de code voldoet aan best practices. Vervolgens kan Terraform automatisch een plan en apply uitvoeren om infrastructuur aan te maken.

## Voordelen
CI/CD zorgt voor minder handmatig werk en minder kans op fouten. Omdat alle wijzigingen via GitHub lopen, is duidelijk wie welke wijziging heeft gedaan. Door automatische controles worden fouten sneller ontdekt voordat infrastructuur of configuratie wordt aangepast.

## Consequenties
Er zijn ook risico's. Een fout in een workflow kan ervoor zorgen dat verkeerde infrastructuur wordt aangemaakt of verwijderd. Daarom is het belangrijk om secrets veilig op te slaan, rechten te beperken en destroy-acties alleen handmatig te laten starten. Ook moet de lokale GitHub Runner goed beveiligd worden, omdat deze toegang kan hebben tot interne systemen.

## Conclusie
CI/CD kan in mijn organisatie worden ingezet om infrastructuur en serverconfiguratie betrouwbaarder en sneller te beheren. De combinatie van GitHub Actions, een lokale runner, Ansible en Terraform past goed bij Infrastructure as Code. Belangrijk is wel dat er duidelijke controlepunten zijn, zoals linting, syntax checks en handmatige goedkeuring voor risicovolle acties zoals destroy.
