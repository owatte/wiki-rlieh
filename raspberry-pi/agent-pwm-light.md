#Installation et configuration de l'agent lumière (PWM)

Cet agent gère les phases de lumière (lever, couchers de soleil etc ...), et relance l'éclairage si besoin après une coupure d'électricité

# Installation docker pi-blaster
```
ssh rlieh@rlieh.local
cd ~/src
git clone https://github.com/sarfata/pi-blaster.git
cd pi-blaster
docker build -t pi-blaster .
/usr/bin/docker run -it --privileged --rm -v /dev:/dev pi-blaster
(crontab -l ; echo "@reboot /usr/bin/docker run -it --privileged --rm -v /dev:/dev pi-blaster &") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -
```
