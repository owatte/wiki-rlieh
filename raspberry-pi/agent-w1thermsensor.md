
# Installation et configuration de l'agent suivi de température avec des sondes DS18B20

Cet agent suit et contrôle les températures via des sondes de type DS18B20, selon le protocole 1-wire et permet :
- l'enregistrement de la valeur mesurée toutes les 5 minutes (avec graphiques semaine/mois/année)
- la définition de seuils de notifications et d'alertes Telegram, WhatsApp ou mail.
- la communication avec des appareils dont l'activation ou le fonctionnement dépendent de la température mesurée (fonction de thermostat)

L'agent utilise [W1ThermSensor](https://github.com/timofurrer/w1thermsensor) et supporte les sondes de température 1-wire :
  - DS18S20
  - DS1822
  - DS18B20
  - DS28EA00
  - DS1825/MAX31850K



## Installation hardware

### Brochage et connection de la sonde

On utilise des sondes DS18B20 étanches (exemple [adafruit](https://www.adafruit.com/?q=waterproof%20DS18B20%20)). 
 
Ces sondes ont 3 pins : masse (GND), alimentation 3.3V (VDD) et data (DQ) : le 1 wire utilise 1 seul GPIO et peut chaîner plusieurs sondes

Les kits RLIEH pour les développeurs et les beta-testeurs utilisent des connecteurs grove et sont prêts à l'emploi. Si vous utilisez une breadboard pour votre montage, il vous faudra également des jumpers et une résistance 4.7kΩ ou 10kΩ.


le [`config.txt`](rlieh-hypriot-config.txt) de votre raspberry Pi doit contenir la ligne suivante : 
```
dtoverlay=w1-gpio,gpiopin=6
```

Cette ligne est déjà présente dans la distribution Rlieh pour Raspberry Pi


## Installation

```
sudo apt-get install python3-w1thermsensor
```


