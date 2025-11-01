apt update -y && apt install -y acl

adduser --disabled-password --gecos "" adminuser
echo 'adminuser:Admin123!' | chpasswd
usermod -aG sudo adminuser

adduser --disabled-password --gecos "" poweruser

echo "poweruser ALL=NOPASSWD: /sbin/iptables" | tee /etc/sudoers.d/poweruser
chmod 0440 /etc/sudoers.d/poweruser

chmod 700 /home/adminuser
setfacl -m u:poweruser:rx /home/adminuser

sudo -u poweruser ln -s /etc/mtab /home/poweruser/mtab_link