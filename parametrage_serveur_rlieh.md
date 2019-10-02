## Paramétrage serveur RLIEH
Le fonctiomment d'un serveur RLIEH repose sur agents, activés par des tâches plannifiées, ponctuelles ou répétées, et configurés dans des fichiers .INI

Le serveur peut également dialoguer avec un serveur RLIEH pour activer des équipements gérés et lire les valeurs des sondes

### Gestion éclairage 
Les PWM sont gérés via l'API web RLIEH (satelittes + serveur local) ou en ligne de commande (serveur local uniquement)

Il est possible de définir des phases d'éclairage et de les déclancher à des heures plannifiées 

#### Installation composants logiciels

##### Installation piblaster

La gestion du PWM sur le raspberry Pi est assurée par [pi-blaster](https://github.com/sarfata/pi-blaster)

<code>
mkdir /home/pi/src
cd /home/pi/src
git clone https://github.com/sarfata/pi-blaster.git
cd pi-blaster
sudo apt-get install debhelper dh-autoreconf dh-systemd dpkg-dev \
init-system-helpers autoconf
sudo dpkg -i ../pi-blaster_0.1.2_armhf.deb
</code>

#### Définition des phases d'éclairage

La création d'une phase d'éclairage via PWM repose sur 3 paramètres : 
1. l'intensité d'éclairage de début (en %, avec 1 précision de 1 dixième ex: 0.1)
2. l'intensité d'éclairage de fin (en %)
3. la durée de la modulation (en secondes)

#### Déclanchement d'une phase d'éclairage

Le système RLIEH utilise `cron`, le service de gestion de tâches plannifiées de GNU/Linux, qui permet dé déclancher ces phases d'éclairage, à des moments précis, identiques ou différents chaque jour 

### Rlieh-sat-light

rlieih-sat-light est dédié à la gestion des éclairages en PWM activé par réseau (ESP ou Raspberry Pi, local ou distant, avec API RLIEH)


#### Commande 
```
rlieh-sat-light -i fichier-de-configuration -p phase-de-lumiere
```

#### Fichier de configuration

##### Section hardware
La section ''hardware'' est différente pour le serveur et un sat. (TODO: uniformiser la section hardware)

Pour un satelitte ou un serveur distant gérér via l'API web, il faut préciser l'`ip` et le `pwm_channel`; pour le contrôleur RLIEH local, il faut en plus indiquer le GPI0 (`pin`) (TODO renommer pin en gpio),

##### section light_thresholds

La section ''light_thresholds'' permet de définir les phases avec pour chacune, l'intensité de début et de fin
`phase = [debut, fin]`

#### section light_duration

La section ''light_duration'' permet de définir la durée d'une phase en secondes
`phase = 600` (600 = 60 * 10 = 10 mn)  

#### Fichier exemple
```
[hardware]
type = sat
ip = 192.168.1.43
pwm_channel = 0
; type = controller
; pin = 18


; light pwm values
[light_thresholds]
dawn = [0, 20]
sunrise = [20, 100]
sunset = [100, 20]
dusk  = [20, 0]
test = [100, 0]
acclimation = [100, 20]

; use json.load with configparser to read lists in .ini
; see https://stackoverflow.com/questions/335695/lists-in-configparser

; light modulation phases duration (in mn)
[light_duration]
dawn = 600
sunrise = 1200
sunset = 1200
dusk = 600
test = 10
acclimatation = 5 
```

