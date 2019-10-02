## Installation d'un système RLIEH sur Raspberry Pi

Apres l'[installation de raspbian](installation_raspbian.md), il reste pour lancer le système de gestion de l'aquarium ou du terrarium, à installer quelques outils logiciels puis paramétrer des tâches plannifiées pour activer les agents

### 1er boot, post-install Raspbian 

#### Copie clé SSH et 1ère connexion SSH

<code>
ssh-copy-id pi@IP-RASPI
ssh pi@IP-RASPI
</code>

#### Mise à jour système

<code>
sudo apt-get update && sudo apt-get upgrade
</code>

#### Raspi-config

<code>
sudo raspi-config
</code>

  * 1. Change user password
  * 2. Network Options
    *    N1 Hostname
  * 4. Localization Options
    *  I1 Change locale (fr_FR.UTF-8 UTF-8)
    *  I2 Change Timezone
    *  I3 Change Keyboard layout
  * 5. Interfacing Options
    * P1 enable camera
    * P2 enable SSH server
    * P5 enable I2C
    * P7 enable one-wire interface
  * 7.Update

Reboot



#### Python 

<code>
sudo apt-get install git python3-pip
</code>

### Installation composants logiciels RLIEH

<code>
sudo pip3 install rlieh-satlight rlieh_pwm W1ThermSensor
</code> 
