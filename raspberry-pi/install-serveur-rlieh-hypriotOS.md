# Installation du Serveur RLIEH Controller sur Hypriot OS

HypriotOS est une version optimisée IOT et Docker de Raspbian lite. C'est probablement le meilleur choix pour un serveur RLIEH :
- dernieres versions de `docker` et `docker-compose`
- serveur SSH activé par défaut
- support de [cloud-init](https://cloudinit.readthedocs.io/en/latest/) pour construire sa propre image (avec le WiFi configuré) et un paramétrage automatique lors du 1er boot

## Installation

1. Installez [flash](https://github.com/hypriot/flash)<br> 
Attention : flash a quelques [dépendances](https://github.com/hypriot/flash#install-dependencies)<br> 
Remarque : l'outil flash est uniquement disponible pour GNU/Linux et Mac OS.
2. Téléchargez le fichier [cloud-init.yml](rlieh-hypriot-cloud-init.yml)

```
$ wget https://raw.githubusercontent.com/owatte/wiki-rlieh/master/raspberry-pi/rlieh-hypriot-cloud-init.yml -O rlieh-hypriot-cloud-init.yml
```
2. Modifiez le fichier télécharger avec vos paramètres WiFi<br>
```
      ssid="YourSSID"
      psk="YourSecretPreSharedKey"
```
3. Téléchargez le fichier [config.txt](rlieh-hypriot-config.txt) (active WiFi et 1-wire)
```
$ wget https://raw.githubusercontent.com/owatte/wiki-rlieh/master/raspberry-pi/rlieh-hypriot-config.txt -O rlieh-hypriot-config.txt
```
4. Flashez la SD card (ou le périphérique USB) en incluant les fichiers de configuration de l'image
```
$ flash --device /dev/sdb \ 
--bootconf rlieh-hypriot-config.txt \
--userdata rlieh-hypriot-cloud-init.yml \
https://github.com/hypriot/image-builder-rpi/releases/download/v1.11.2/hypriotos-rpi-v1.11.2.img.zip
```

5 `ssh rlieh@black-pearl.local`

Pour les personnes ne pouvant pas utiliser l'outil de construction d'image, une image standard préconstruite est disponible.
TODO publier img sur github, ajouter lien vers img + vers doc hypriot https://blog.hypriot.com/getting-started-with-docker-on-your-arm-device/ etc ...)
