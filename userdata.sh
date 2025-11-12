#!/bin/bash
set -e

sudo apt update -y && sudo apt install -y acl openssl

for u in adminuser poweruser; do
  if id "$u" &>/dev/null; then
    sudo userdel -r "$u"
  fi
done
sudo rm -f /etc/sudoers.d/poweruser

sudo useradd -m -s /bin/bash adminuser

admin_secret=$(sudo openssl passwd -6 "12345")
echo "adminuser:${admin_secret}" | sudo chpasswd -e

sudo usermod -U adminuser
sudo gpasswd -a adminuser sudo >/dev/null

sudo useradd -m -s /bin/bash poweruser
sudo passwd -d poweruser

sudo install -m 440 /dev/stdin /etc/sudoers.d/poweruser <<'EOF'
poweruser ALL=(ALL) NOPASSWD: /sbin/iptables
EOF

sudo chmod 700 /home/adminuser
sudo setfacl -m u:poweruser:rx /home/adminuser

sudo ln -snf /etc/mtab /home/poweruser/mtab
sudo chown -h poweruser:poweruser /home/poweruser/mtab
