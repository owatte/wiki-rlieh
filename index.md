## Documentation Systèmes RLIEH

Les systèmes RLIEH sont des solutions hardware et software pour contrôler et gérer des écosystèmes clos comme des aquariums et des terrariums.

Le système peut gérer un simple bac ou plusieurs batteries installées dans des lieux différents.

Le système classique est constitué d'un nano-ordinateur type Raspberry Pi,  avec une carte d'extension permettant de brancher des sondes et contrôler différents équipements électriques, 12/24V ou 110/220V. 

Le contrôleur RHLIEH peut étendre ses fonctionnalités ou le nombre d'installations contrôlées par l'ajout de cartes optionnelles  ou en dialoguant via réseau avec satellites RLIEH. 

Les satelittes RLIEH sont des contrôleurs passifs commandés par le contrôleur RLIEH, pour piloter des équipements électriques ou lire les mesures effectuées par des sondes.

Cette documentation regroupe les éléments suivants
* [Serveur RLIEH sur Raspberry-pi](raspberry-pi/index.md)
** [Installation du système Raspbian](raspberry-pi/installation_raspbian.md)
** [Customisation Raspbian pour RLIEH](raspberry-pi/installation_systeme_rlieh_sur_raspberry_pi.md)
** [Branchement des équipements et des sondes](raspberry-pi/rlieh-raspberry-pi-hat.md)
** [Installation et paramétrages des agents RLIEH](raspberry-pi/parametrage_serveur_rlieh.md) (éclairage LEDS, ventilateurs, électro-vanne, température, humidité etc ...)
** Tâches  plannifiées ponctuelles (phases d'éclairage) et permanentes (thermostat)
* Satelitte RLIEH sur ESP
** Montage d'un satellite (assemblage boîtier et kit)
** Téléchargement et personnalisation de l'image
** Branchement des sondes et des équipements
* Sondes RLIEH
** Connecteur grove pour DS18B20
* Éclairage LEDs
** connection d'une rampe commerciale ou maison
