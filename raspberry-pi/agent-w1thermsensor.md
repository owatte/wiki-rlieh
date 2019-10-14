 sudo apt-get install python3-w1thermsensor
# Installation et configuration de l'agent suivi de température avec des des sondes DS18B20

Cet agent suit et contrôle les températures via des sondes de type DS18B20, selon le protocole 1-wire et permet :
- l'enregistrement de la valeur mesurée toutes les 5 minutes (avec graphiques semaine/mois/année)
- la définition de seuils de notifications et d'alertes Telegram, WhatsApp ou mail.
- la communication avec des appareils dont l'activation ou le fonctionnement dépendent de la température mesurée (fonction de thermostat)


## Préinstallation

le [`config.txt`](rlieh-hypriot-config.txt) de votre raspberry Pi doit contenir la ligne suivante : 
```
dtoverlay=w1-gpio,gpiopin=6
```
Cette ligne est déjà présente dans la distribution Rlieh pour Raspberry Pi


## Installation
```
sudo apt-get install python3-w1thermsensor
```


