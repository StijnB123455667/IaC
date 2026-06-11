# Inzet van Ansible roles in mijn organisatie

## Situatie

Binnen een organisatie worden vaak meerdere servers gebruikt voor websites, databases, monitoring en interne applicaties. Zonder automatisering worden deze servers handmatig ingericht. Daardoor kunnen verschillen ontstaan tussen servers, bijvoorbeeld andere softwareversies of vergeten configuratiestappen.

## Hoe Ansible roles kunnen helpen

Ansible roles kunnen worden gebruikt om standaard serverconfiguraties herbruikbaar te maken. Een role bevat taken, variabelen, handlers, templates en bestanden voor één logisch onderdeel. Voorbeelden zijn:

- een webserver-role voor Apache, PHP en firewallregels;
- een database-role voor MySQL, gebruikers en databases;
- een monitoring-role voor agents zoals node_exporter;
- een security-role voor updates, SSH-hardening en gebruikersbeheer.

Door deze roles in GitHub te bewaren kan het team wijzigingen controleren via pull requests. Daarna kan dezelfde role worden gebruikt voor test-, acceptatie- en productieomgevingen.

## Toepassing in mijn werk

In mijn eigen werk zou ik Ansible roles gebruiken om ontwikkel- en testomgevingen sneller op te bouwen. Een nieuwe webserver kan dan met één playbook dezelfde configuratie krijgen als bestaande servers. Dit bespaart tijd en voorkomt fouten door handmatige installatie.

Een praktisch voorbeeld is een standaard webapplicatieomgeving:

1. De webserver-role installeert Apache, PHP en benodigde modules.
2. De database-role installeert MySQL en maakt een applicatiegebruiker aan.
3. Een deploy-role zet de applicatiebestanden klaar.
4. Een security-role zorgt voor updates en veilige basisinstellingen.

## Consequenties

Het gebruik van Ansible roles heeft voordelen, maar ook gevolgen. Het team moet duidelijke afspraken maken over naamgeving, variabelen en versiebeheer. Rollen moeten getest worden voordat ze op productie worden uitgevoerd. Wachtwoorden mogen niet hardcoded in GitHub staan bij echte productieomgevingen; daarvoor kan Ansible Vault worden gebruikt.

Ook moet documentatie worden bijgehouden, zodat andere beheerders begrijpen welke role waarvoor bedoeld is. Als roles goed worden onderhouden, zorgt dit voor snellere deployments, minder configuratiefouten en betere samenwerking.

## Conclusie

Ansible roles maken infrastructuur herbruikbaar, controleerbaar en beter overdraagbaar. Voor een organisatie betekent dit minder handmatig werk, meer standaardisatie en een kleinere kans op fouten. Vooral in omgevingen met meerdere servers of terugkerende installaties zijn roles een goede oplossing.
