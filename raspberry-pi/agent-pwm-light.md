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
```

## Paramétrage des phases d'éclairage

Le serveur RLIEH Controller peut gérér des éclairages de LEDs branchées sur le raspberry Pi ainsi que des éclairages distants branchés sur des satellites RLIEH


Les phases de lumière sont paramétrées dans un fichier ini qui précise
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
```
```




