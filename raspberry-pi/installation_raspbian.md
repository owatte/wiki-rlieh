## Installation Raspbian

L'installation de Raspbian sur RaspberryPi se fait depuis une station de travail, en 3 étapes : 
  - téléchargement d'une image compressée de Raspbian ;
  - copie de l'image téléchargée sur une carte microSD ou [sur un périphérique USB externe](installation_sur_cle_usb.md), avec un outil spécifique. 
  - modification de l'image téléchargée avant le 1er boot 

Àprès ces 3 étapes, vous pourrez insérer votre carte SD dans le Raspberry Pi et le booter.

### Téléchargement 

Téléchargement : [www.raspberrypi.org/do.wnloads/raspbian/](https://www.raspberrypi.org/downloads/raspbian/)

Note : on utilise utilise Raspbian lite, c'est à dire **la version sans desktop**
 
### Installation

Documentation officielle pour installer Raspbian à partir de différents systèmes d'exploitation : [raspberrypi.or/installing](https://www.raspberrypi.org/documentation/installation/installing-images/) (anglais)

#### Installation via `dd` 

```
dd bs=4M if=2019-09-26-raspbian-buster-lite.img of=/dev/sdX conv=fsync
```
raspberrypi.org / [Installing operating system images on Linux](https://www.raspberrypi.org/documentation/installation/installing-images/linux.md)
 
#### Installation sur clé USB ####

Un article est dédié à l'[installation sur périphérique USB](installation_sur_cle_usb.md) (clé USB, HDD, SSD)

### Modifications avant 1er boot

On modifie le système pour être utilisable via réseau dès le 1er boot (
[headless system](https://www.raspberrypi.org/documentation/configuration/wireless/headless.md))

Ces actions sont à appliquer dans la partition boot (partition FAT32), avant le 1er boot. 

Si vous avez plusieurs systèmes à installer, vous pouvez modifier directement l'image téléchargée sur votre disque dur en utilisant l'option de montage '' -o loop ''

#### Activation du SSH
 
Ajouter un fichier vide appelé `ssh` 

Note : ce fichier sera détruit lors du boot et sa création ne vous épargne pas de l'activation du serveur SSH via raspi-config

#### Configuration du WiFi

Créer un fichier `wpa_supplicant.conf`

##### Exemple wpa_supplicant.conf
 
 
```country=us
update_config=1
ctrl_interface=/var/run/wpa_supplicant

network={
 ssid="<Name of your WiFi>"
 psk="<Password for your WiFi>"
}
```

#### Config.txt

Ajouter `dtoverlay=w1-gpio,gpiopin=6`  + éventuellement instruction pour boot sur périphérique USB `program_usb_boot_mode=1` à la fin du config.txt à la racine de la partition

