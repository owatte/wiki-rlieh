## Paramétrage serveur RLIEH
Le fonctiomment d'un serveur RLIEH repose sur agents, activés par des tâches plannifiées, ponctuelles ou répétées, et configurés dans des fichiers .INI

Le serveur peut également dialoguer avec un serveur RLIEH pour activer des équipements gérés et lire les valeurs des sondes

### Gestion éclairage 
Les PWM sont gérés via l'API web RLIEH (satelittes + serveur local) ou en ligne de commande (serveur local uniquement)

Il est possible de définir des phases d'éclairage et de les déclancher à des heures plannifiées 

#### Définition des phases d'éclairage

La création d'une phase d'éclairage via PWM repose sur 3 paramètres : 
1. l'intensité d'éclairage de début (en %, avec 1 précision de 1 dixième ex: 0.1)
2. l'intensité d'éclairage de fin (en %)
3. la durée de la modulation (en secondes)

#### Déclanchement d'une phase d'éclairage

Le système RLIEH utilise `cron`, le service de gestiond de tâches plannifiées de GNU/Linux, qui permet dé déclancher ces phases d'éclairage, à des moments précis, identiques ou différents chaque jour 

### Rlieh-sat-light

rlieih-sat-light est dédié à la gestion des éclairages en PWM activé par réseau (ESP ou Raspberry Pi, local ou distant, avec API RLIEH)


#### Commande 
```
rlieh-sat-light -i fichier-de-configuration -p phase-de-lumiere
```

#### Fichier de configuration

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
noon = [75, 100, 75] ; unused
sunset = [100, 20]
dusk  = [20, 0]
test = [100, 0]

; use json.load with configparser to read lists in .ini
; see https://stackoverflow.com/questions/335695/lists-in-configparser

; light modulation phases duration (in mn)
[light_duration]
dawn = 10
sunrise = 10
sunset = 10
dusk = 10 
test = 0.1
```

