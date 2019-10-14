## Installation d'un système RLIEH sur Raspberry Pi

Apres l'[installation de raspbian](installation_raspbian.md), il reste pour lancer le système de gestion de l'aquarium ou du terrarium, à installer quelques outils logiciels puis paramétrer des tâches plannifiées pour activer les agents

### 1er boot, post-install Raspbian 

#### Copie clé SSH et 1ère connexion SSH

```
ssh-copy-id pi@IP-RASPI
ssh pi@IP-RASPI
```
#### Mise à jour système

```
sudo apt-get update && sudo apt-get upgrade
```

#### Raspi-config

##### Ansible Raspi-confg

La configuration d'un raspberry Pi avec le système raspbian-lite peut se faire avec un script ansible

```
wget https://raw.githubusercontent.com/owatte/ansible-raspi-config/master/raspi-config.yml -O rlieh-raspi-config.yml
```

sudo raspi-config
```

Options à modifier :

  * 1 Change user password
  * 2 Network Options
    *    N1 Hostname
  * 4 Localization Options
    *  I1 Change locale (fr_FR.UTF-8 UTF-8)
    *  I2 Change Timezone
    *  I3 Change Keyboard layout
  * 5 Interfacing Options
    * P1 enable camera
    * P2 enable SSH server
    * P5 enable I2C
    * P7 enable one-wire interface


```
Reboot

#### Python 
```
sudo apt-get install git python3-pip
```
#### Répertoire home

```
mkdir -p /home/pi/{bin,src,conf,crontab}
echo 'export PATH=/home/pi/bin:$PATH'  >> /home/pi/.bashrc'
```
#### Cron

```
crontab -u user - <<EOF
# m h  dom mon dow   command
MAILTO=""
EOF
ln -s /var/spool/cron/crontabs/pi /home/pi/crontab/pi
```

#### Répertoire de logs

```
sudo mkdir /var/log/rlieh
sudo chown user: /var/log/rlieh/
``` 

#### Installation  Munin

Munin est un outil de surveillance système et réseau open source sous licence publique générale GNU3. Il s'appuie sur l'outil RRDTool. Il présente ses résultats sous forme de graphiques disponibles via une interface web. Il possède une structure de plugins particulièrement simple qui permet d'enrichir rapidement l'outil.(source : [wikipedia](https://fr.wikipedia.org/wiki/Munin_(logiciel)))

```
sudo apt install munin munin-node lighttpd
sudo mkdir  -p /var/www/munin
sudo chown munin:munin /var/www/munin

```
```
sudo nano /etc/munin/munin.conf
```
changer la ligne `htmldir`
```
htmldir /var/www/munin
```

```
sudo nano /etc/lighttpd/lighttpd.conf
```
changer la ligne document-root
```
server.document-root ="/var/www"
```
Et voilà !
