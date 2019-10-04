## Installation Raspbian sur clé USB

### Problématique 

Par défaut, le systèmè de Raspberry Pi est censé s'installer sur une SD card. Cependant, la SD card a un mombre assez limité d'écriture et finit systématiquement par cracher. Même si une SD card est peu chère et simple à sauvegarder/restaurer, cela fragilise le contrôleur et n'est donc pas envisageable. Je préfère donc installer le système sur un suppport externe (clé USB, SSD, disque dur externe), d'autant plus, que outre son action de contrôleur, je stocke aussi dessus des enregistrements réguliers des données mesurées par les capteurs

### Modèles, de Rapsberry Pi 

#### Rasperry Pi 4 

Le boot sur support externe n'est pas encore possible sur le Pi4

#### Raspberry Pi 3B+

Pour le Raspberry Pi 3B+, c'est automatique : il suffit simplement d'installer l'OS sur la clé USB

#### Modèles antérieurs au Raspberry Pi 3B+

Vous avez besoin d'une clé USB (ou disque dur ou SSD) et également d'une carte micro SD. 

  - Installez le système sur la clé USB et sur la micro SD ;
  - dans la partition boot de la micro SD, modifiez le `config.txt` en ajoutant à la fin du fichier la ligne suivante : `program_usb_boot_mode=1` ;
  - démarrez le Raspberry Pi avec seulement la Micro SD (cela configurera le Raspberry Pi pour booter sur un périphérique extérieur) ;
  - éteignez le Raspberry Pi ;
  - retirez la SD card et insérez votre périphérique USB
  - redémarrez le Raspberry Pi 

### Vérification installation sur US

Pour vérifier que l'instruction de boot sur USB est correctement configurée, taper

```
vcgencmd otp_dump | grep 17
```

La commande doit retourner : `17:3020000a`. Si oui, vous pouvez éteindre et redémarrer sans clé USB, et si non, recommencez.
