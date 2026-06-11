# Inzet van Terraform, Ansible en CI/CD binnen een cybersecuritybedrijf

Binnen een cybersecuritybedrijf kan deze aanpak worden gebruikt om klantomgevingen sneller en consistenter op te zetten. Een standaard deployment kan bijvoorbeeld bestaan uit een lokale server bij de klant en een cloudcomponent in Azure. De lokale server verzamelt logging uit het netwerk van de klant, terwijl de cloudcomponent gebruikt kan worden voor analyse, beheer of centrale opslag.

Terraform kan worden gebruikt om infrastructuur reproduceerbaar aan te maken. Denk aan virtuele machines, netwerken, security groups, public IP-adressen en lokale VM's op een ESXi omgeving. Hierdoor is achteraf precies te zien welke resources zijn aangemaakt.

Ansible kan daarna de configuratie van de systemen uitvoeren. Voorbeelden zijn het aanmaken van gebruikers, installeren van Docker, plaatsen van SSH keys, configureren van logging agents en starten van containers. Door roles te gebruiken wordt deze configuratie herbruikbaar voor meerdere klanten.

CI/CD kan worden ingezet om wijzigingen gecontroleerd uit te rollen. Een Docker image kan automatisch gebouwd worden wanneer code naar GitHub wordt gepusht. Daarna kan de deployment via een self-hosted runner worden uitgevoerd, zodat ook interne ESXi-systemen bereikbaar zijn.

De voordelen zijn snelheid, minder handmatige fouten, betere standaardisatie en betere documentatie. De belangrijkste aandachtspunten zijn beveiliging van secrets, controle op wijzigingen, testen voordat code naar klantomgevingen gaat en het beperken van toegang tot de runner en Terraform state.
