## Installation et configuration de l'agent lumière (PWM)

Cet agent gère les phases de lumière (lever, couchers de soleil etc ...), et relance l'éclairage si besoin après une coupure d'électricité

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


Une phase d'éclairage se lance avec la commande suivante:
```
rlieh-pwm range BEGIN END GPIO [--duration=MINUTES] [--log-level=LOG_LEVEL]
```
La carte standard RLIEH contrôleur utilise les GPIO 18 et 19 pour le PWM

Exemple aurore de 0 à 20% d'éclairage sur une durée de 10 mn
```
rlieh-pwm range 0 20 18 --duration=10
```
TODO ajouter appel via fichier.ini comme pour un sat. via l'API RLIEH

### LEDs connectées sur un satellite RLIEH

Les phases d'éclairage sont définies dans des fichier .INI, avec un fichier par bac

Structure du fichier .INI pour l'éclairage
Ce fichier doit contenur 3 séctions 

- hardware
  - nature du controlleur (sat ou server)
  - ip du satellite
  - canal du satellite (0 ou 1)
- light thresholds
  - nom de la phase
  - niveaux de lumière [start, stop] 
- duration
  - durée de la phase en minutes 

Exemple cuve matouba

4 phases quotidiennes 
- aurore (dawn) 0 à 20% sur 10 mn
- lever de soleil (sunrise) 20 à 100% sur 10 mn
- coucher de soleil (sunset) 100 à 20% sur 10 mn
- crépuscule 20% à 0 sur 10 mn

2 phases exceptionnelles
- test de 100% à 0 en 6 secondes
- acclimatation de 100 à 25% en 6 secondes

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




