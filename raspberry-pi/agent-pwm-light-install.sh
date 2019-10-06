echo "Construction docker PWM"
cd ~/src
git clone https://github.com/sarfata/pi-blaster.git
cd pi-blaster
docker build -itd pi-blaster .
echo "Lancement docker PWM en tant que service"
/usr/bin/docker run -itd --privileged --rm -v /dev:/dev pi-blaster
(crontab -l ; echo "@reboot /usr/bin/docker run -itd --privileged --rm -v /dev:/dev pi-blaster &") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -
echo "Installation commandes RLIEH"
sudo pip3 install rlieh-satlight rlieh_pwm
sudo mkdir /var/log/rlieh/
sudo chown rlieh: /var/log/rlieh/
