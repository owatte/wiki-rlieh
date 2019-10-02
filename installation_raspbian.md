## Installation Raspbian

L'installation de Raspbian sur RaspberryPi se fait depuis un desktop, en 3 étapes : 
  - téléchargement d'une image compressée de Raspbian ;
  - copie de l'image téléchargée sur une carte microSD ou [installation_sur_cle_usb.md](sur un périphérique USB externe), avec un outil spécifique : [https://www.raspberrypi.org/documentation/installation/installing-images/](raspberrypi.or/installing) images (anglais)
  - modification de l'image téléchargée avant le 1er boot 

### Téléchargement 

Note : on utilise utilise Raspbian lite, c'est à dire **la version sans desktop**
 
[https://www.raspberrypi.org/downloads/raspbian/](www.raspberrypi.org/do.wnloads/raspbian/)

### Installation

#### Installation via `dd` 

<code>
dd bs=4M if=2019-09-26-raspbian-buster-lite.img of=/dev/sdX conv=fsync
</code>

raspberrypi.org / [https://www.raspberrypi.org/documentation/installation/installing-images/linux.md](Installing operating system images on Linux)


#### Installation via Flash

Utilisateur Linux, je signale l'outil [https://github.com/hypriot/flash](flash) développé par l'équipe de Hypriot OS. 
Attention : flash a quelques [https://github.com/hypriot/flash#install-dependencies](dépendances) 

<code>
flash --hostname rlieh --ssid mon-hotspot --password mon-hotspot-psk --device /dev/mmcblk0 https://downloads.raspberrypi.org/raspbian_lite_latest
</code>

Ma dernière utilisation de Flash n'a pas fonctionné pour le paramétrage du WiFi et semble-t-il a juste copié l'image (+ la téclécharger) sur la SD  

À vérifier si toujours possibilité de copie d'un config.txt surchargé 
 
#### Installation sur clé USB ####

Un article est dédié à l'[installation_sur_cle_usb.md](installation sur périphérique USB) (clé USB, HDD, SSD)

### Modifications avant 1er boot

On modifie le système pour être utilisable via réseau dès le 1er boot (
[https://www.raspberrypi.org/documentation/configuration/wireless/headless.md](headless system) et activer la prise en compte de certains bus ou protocoles utilisés par les sondes (ex : [https://en.wikipedia.org/wiki/1-Wire](1-Wire)

Ces actions sont à appliquer dans la partition boot (partition FAT32), avant le 1er boot. 

Si vous avez plusieurs systèmes à installer, vous pouvez modifier directement l'image téléchargée sur votre disque dur en utilisant l'option de montage '' -o loop ''

#### Activation du SSH
 
Ajouter un fichier vide appelé `ssh` 

Note : ce fichier sera détruit lors du boot et sa création ne vous épargne pas de l'activation du serveur SSH via raspi-config

#### Configuration du WiFi

Créer un fichier `wpa_supplicant.conf`

##### Exemple
 
 
<code>
country=us
update_config=1
ctrl_interface=/var/run/wpa_supplicant

network={
 ssid="<Name of your WiFi>"
 psk="<Password for your WiFi>"
}
</code>

#### Config.txt

Ajouter `dtoverlay=w1-gpio,gpiopin=6`  + éventuellement instruction pour boot sur périphérique USB `program_usb_boot_mode=1` à la fin du config.txt à la racine de la partition

