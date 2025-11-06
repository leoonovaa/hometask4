#!/bin/bash
sudo apt update -y && apt install -y acl

sudo adduser --disabled-password --gecos "" adminuser
echo 'adminuser:Admin123!' | sudo chpasswd
sudo usermod -aG sudo adminuser

sudo adduser --disabled-password --gecos "" poweruser
sudo passwd -d poweruser

echo "poweruser ALL=NOPASSWD: /sbin/iptables" | sudo tee /etc/sudoers.d/poweruser
sudo chmod 0440 /etc/sudoers.d/poweruser

sudo chmod 700 /home/adminuser
sudo setfacl -m u:poweruser:rx /home/adminuser

sudo -u poweruser ln -s /etc/mtab /home/poweruser/mtab_link
