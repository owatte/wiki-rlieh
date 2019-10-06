# @Author: Olivier Watté <user>
# @Date:   2019-10-05T03:43:40-04:00
# @Email:  owatte@ipeos.com
# @Last modified by:   user
# @Last modified time: 2019-10-06T13:54:50-04:00
# @License: GPLv3
# @Copyright: IPEOS I-Solutions

echo "Lancement docker PWM en tant que service"
/usr/bin/docker run -itd --privileged --rm -v /dev:/dev pi-blaster
(crontab -l ; echo "@reboot /usr/bin/docker run -itd --privileged --rm -v /dev:/dev pi-blaster &") 2>&1 | grep -v "no crontab" | sort | uniq | crontab -

echo "Installation commandes RLIEH"
sudo pip3 install rlieh-satlight rlieh_pwm
sudo mkdir /var/log/rlieh/
sudo chown rlieh: /var/log/rlieh/
