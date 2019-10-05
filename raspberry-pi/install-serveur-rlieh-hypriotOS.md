# Installation du Serveur RLIEH Controller sur HypriotOS

HypriotOS est une version optimisée IOT et Docker de Raspbian lite. C'est probablement le meilleur choix pour un serveur RLIEH :
- dernieres versions de `docker` et `docker-compose`
- serveur SSH activé par défaut
- support de cloud-init pour construire sa propre image (avec le WiFi configuré) et un paramétrage automatique lors du 1er boot

## Installation rapide
$ wget https://raw.githubusercontent.com/owatte/wiki-rlieh/master/raspberry-pi/rlieh-hypriot-config.txt -O rlieh-hypriot-config.txt
$ wget https://raw.githubusercontent.com/owatte/wiki-rlieh/master/raspberry-pi/rlieh-hypriot-cloud-init.yml -O rlieh-hypriot-cloud-init.yml
$ flash --bootconf rlieh-hypriot-config.txt --metadata rlieh-hypriot-cloud-init.txt  https://github.com/hypriot/image-builder-rpi/releases/download/v1.11.2/hypriotos-rpi-v1.11.2.img.zip
$ ssh pirate@black-pearl.local

Pour les personnes ne pouvant pas utiliser l'outil de construction d'image, une image standard préconstruite est disponible.
TODO publier img sur github, ajouter lien vers img + vers doc hypriot https://blog.hypriot.com/getting-started-with-docker-on-your-arm-device/ etc ...)

## Construction de l'image du serveur RLIEH Controller avec flash

### Installation flash

Installez [flash](https://github.com/hypriot/flash#installation) 

Attention : flash a quelques [dépendances](https://github.com/hypriot/flash#install-dependencies) 

### Téléchargement fichiers de conf

Télécharger [rlieh-hypriot-cloud-init.yml](rlieh-hypriot-cloud-init.yml) et [rlieh-hypriot-config.txt](rlieh-hypriot-config.txt)
#### Installation via Flash

L'un des points fort de la distribution Hypirot signale l'outil [flash](https://github.com/hypriot/flash) développé par l'équipe de Hypriot OS. 

```
flash --hostname rlieh --ssid mon-hotspot --password mon-hotspot-psk --device /dev/mmcblk0 https://downloads.raspberrypi.org/raspbian_lite_latest
```

Ma dernière utilisation de Flash n'a pas fonctionné pour le paramétrage du WiFi et semble-t-il a juste copié l'image (+ la téclécharger) sur la SD  

À vérifier si toujours possibilité de copie d'un config.txt surchargé 
