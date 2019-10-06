# Installation et configuration de l'agent lumière avec des LEDs(PWM)

Cet agent gère les phases de lumière (lever, couchers de soleil etc ...), et relance l'éclairage si besoin après une coupure d'électricité

Le serveur RHLIEH Controller et les satellites RLIEH peuvent gérér des rampes de LEDS 12 ou 24V, rampes maison et du commerce.

TODO : écrire procédure pour lumière gérée avec des relays (néons etc ...)

## Installation

```
ssh rlieh@rlieh.local
cd ~/src
git clone https://github.com/sarfata/pi-blaster.git
cd pi-blaster
docker build -itd pi-blaster .
/usr/bin/docker run -itd --privileged --rm -v /dev:/dev pi-blaster
(crontab -l ; echo "@reboot /usr/bin/docker run -itd --privileged --rm -v /dev:/dev pi-blaster &") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -
sudo pip3 install rlieh-satlight rlieh_pwm
sudo mkdir /var/log/rlieh/
sudo chown rlieh: /var/log/rlieh/
```

## Paramétrage des phases d'éclairage

Le serveur RLIEH Controller peut gérér des éclairages de LEDs branchées sur le raspberry Pi ainsi que des éclairages distants branchés sur des satellites RLIEH


Les phases de lumière sont définies par
- la quantité de lumière en début et en fin de phase (en pourcent)
- la durée de la phase

### LEDs connectées sur le raspberry Pi


Une phase d'éclairage se lance avec la commande suivante :
```
rlieh-pwm range BEGIN END GPIO [--duration=MINUTES] [--log-level=LOG_LEVEL]
```
La carte standard RLIEH contrôleur utilise les GPIO 18 et 19 pour le PWM

#### Exemple phase aurore

Commande pour progression de 0 à 20% d'éclairage sur une durée de 10 mn
```
rlieh-pwm range 0 20 18 --duration=10
```
TODO ajouter appel via fichier.ini comme pour un sat. via l'API RLIEH

### LEDs connectées sur un satellite RLIEH

Les phases d'éclairage sont définies dans des fichier .INI, avec un fichier par bac

Une phase d'éclairage se lance avec la commande suivante :
```
rlieh-satlight -i <fichier-de-conf.ini> -p <nom-de-phase>

```
#### Structure du fichier .INI pour l'éclairage

Ce fichier doit contenur 3 sections 

- hardware
  - nature du controlleur (sat ou server)
  - ip du satellite
  - canal du satellite (0 ou 1)
- light thresholds
  - nom de la phase
  - niveaux de lumière [start, stop] 
- duration
  - durée de la phase en minutes 

#### Exemple cuve matouba.INI

4 phases quotidiennes 
- aurore (dawn) : 0 à 20% sur 10 mn
- lever de soleil (sunrise) : 20 à 100% sur 10 mn
- coucher de soleil (sunset) : 100 à 20% sur 10 mn
- crépuscule (dusk) : 20% à 0 sur 10 mn

2 phases exceptionnelles
- test : de 100% à 0 en 6 secondes
- acclimatation : de 100 à 25% en 6 secondes

```
[hardware]
type = sat
ip = 192.168.1.43
pwm_channel = 0
; type = server
; pin = 18


; light pwm values
[light_thresholds]
dawn = [0, 20]
sunrise = [20, 100]
sunset = [100, 20]
dusk  = [20, 0]
test = [100, 0]
acclimation = [100, 25]

; use json.load with configparser to read lists in .ini
; see https://stackoverflow.com/questions/335695/lists-in-configparser

; light modulation phases duration (in mn)
[light_duration]
dawn = 10
sunrise = 10
sunset = 10
dusk = 10 
test = 0.1
acclimatation = 0.1

```

## Plannification des phases d'éclairage

Les phases sont appellées dans des tâches plannifiées avec [CRON](https://doc.ubuntu-fr.org/cron)

```
crontab -e
```
### Programmer des phases pour des LEDs sur le raspberry pi
Pour automatiser les phases d'éclairage par LEDs connectées sur le raspberry Pi, il suffit d'ajouter l'appel à la commande `rlieh-pwm` avec la durée et les valeurs de début et de fin de modulation, précédées de l'heure de déclanchement, définie en respectant la syntaxe cron

#### Exemple
Programmation de la phase d'aurore de 0 à 20% en 10 mn, du lundi au vendredi à 10h00 et programmation de la même phase le week-end à 8h30 (éclairage avec carte RLIEH pour raspberry Pi, sur gpio 18)

```
0 10 * * 1-5 /usr/local/bin/rlieh-pwm range 0 20 18 --duration=10
30 8 * * 0,6 /usr/local/bin/rlieh-pwm range 0 20 18 --duration=10

```

### Programmer des phases pour des LEDs branchées sur un satellite RLIEH

Pour faciliter la lecture et l'édition de la cron, je définis la commande d'appel dans une variable, puis appelle cette variable en précisant juste la phase, précédée de l'heure d'appel, définie en respectant la syntaxe cron.

#### Exemple
Programmation de la phase d'aurore de 0 à 20% en 10 mn, du lundi au vendredi à 10h00 et programmatin de la même phase le week-end à 8h30 (RLIEH sat)
```
LIGHT_MATOUBA="/usr/local/bin/rlieh-satlight -i /home/pi/conf/matouba.ini -p "
0 10 * * 1-5 ${LIGHT_MATOUBA} dawn
30 8 * * 0,6 ${LIGHT_MATOUBA} dawn

```
### Fichier cron complet exemple
Ce fichier correspond à la configuration présentée par Mr Hackquarium [Ma fishroom : programmation des phases d’éclairage avec les LEDs](https://hackquarium.lebiklab.com/fishroom-programmation-des-phases-declairage-avec-les-leds/)
```
MAILTO=me@example.com

LIGHT_MATOUBA="/usr/local/bin/rlieh-satlight -i /home/pi/conf/matouba.ini -p "


# RLIEH guardian
*/15 /home/rlieh/bin/rlieh_guardian.py

# morning weekdays
0 10 * * 1-5 ${LIGHT_MATOUBA} dawn
0 10 * * 1-5 /usr/local/bin/rlieh-pwm range 0 20 18 --duration=10
20 10 * * 1-5 ${LIGHT_MATOUBA} sunrise
20 10 * * 1-5 /usr/local/bin/rlieh-pwm range 20 100 18 --duration=10

# morning week-end
30 8 * * 0,6 ${LIGHT_MATOUBA} dawn
30 8 * * 0,6 /usr/local/bin/rlieh-pwm range 0 20 18 --duration=10
50 8 * * 0,6 ${LIGHT_MATOUBA} sunrise 
50 8 * * 0,6 /usr/local/bin/rlieh-pwm range 20 100 18 --duration=10

# evening (weekdays and week-end)
30 20 * * * ${LIGHT_MATOUBA} sunset 
30 20 * * * /usr/local/bin/rlieh-pwm range 100 20 18 --duration=10
50 20 * * * ${LIGHT_MATOUBA} dusk
50 20 * * * /usr/local/bin/rlieh-pwm range 20 0 18 --duration=10
```

TODO ajouter doc pour cron boot et guardian pour ré-allumage éclairage en cas de coupure d'électricité  

