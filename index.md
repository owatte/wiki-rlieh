## Documentation Systèmes RLIEH

Les systèmes RLIEH sont des solutions hardware et software pour contrôler et gérer des écosystèmes clos comme des aquariums, des terrariums ou des serres.

Un contrôleur RLIEH peut gérer un simple bac ou des installations complexes avec plusieurs batteries installées dans des lieux différents.

### Serveur RLIEH Controller
Le système classique est constitué d'un nano-ordinateur type Raspberry Pi,  avec une carte d'extension permettant de brancher des sondes et contrôler différents équipements électriques, 12/24V ou 110/220V. 

Le contrôleur RHLIEH peut étendre ses fonctionnalités ou le nombre d'installations contrôlées par l'ajout de cartes optionnelles  ou en dialoguant via réseau avec satellites RLIEH. 

### Satellite RLIEH Controller
Les satellites RLIEH sont des contrôleurs passifs commandés via une connexion WiFi par le serveur RLIEH, pour piloter des équipements électriques ou lire les mesures effectuées par des sondes.

## Contenu de la documentation
La documentation et le wiki RLIEH sont en cours d'écriture. 

### Serveur RLIEH Controller sur Raspberry-pi 

Le serveur RLIEH Controller sur Raspberry Pi peut s'installer sur les systèmes d'exploitation Arch et Raspbian.

Seule l'installation Raspbian est documentée à l'heure actuelle

  * [Installation du système Raspbian](raspberry-pi/installation_raspbian.md)
  * [Customisation Raspbian pour RLIEH](raspberry-pi/installation_systeme_rlieh_sur_raspberry_pi.md)
  * [Branchement des équipements et des sondes](raspberry-pi/rlieh-raspberry-pi-hat.md)
  * [Installation et paramétrages des agents RLIEH](raspberry-pi/parametrage_serveur_rlieh.md) (éclairage LEDS, ventilateurs, électro-vanne, température, humidité etc ...)
  * Tâches  plannifiées ponctuelles (phases d'éclairage) et permanentes (thermostat)

### satellite RLIEH sur ESP
  * Montage d'un satellite (assemblage boîtier et kit)
  * Téléchargement et personnalisation de l'image
  * Branchement des sondes et des équipements
  * Paramétrage du satellite RLIEH controlleur sur le Serveur RLIEH Controller 

### Sondes RLIEH
  * Connecteur grove pour DS18B20
### Éclairage LEDs
  * connection d'une rampe commerciale ou maison
### API Restful unifiée pour Raspberry Pi et ESP
  * documentation et test de l'API
  * limitations de l'API sur les sats
### Android RLIEH app : commandez vos contrôleurs RLIEH depuis votre smartphone 

