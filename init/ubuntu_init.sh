#!/bin/bash
 
#sudo passwd root
#sudo vim /etc/sudoers

#-------sshd_config-------------
sudo sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && echo "sshd_config is OK!"

sudo systemctl restart ssh && echo "sshd is update!"

#--------/etc/default/grub-------------------
sudo sed -i 's/GRUB_CMDLINE_LINUX=""/GRUB_CMDLINE_LINUX="crashkernel=auto rhgb quiet net.ifnames=0 biosdevname=0"/' /etc/default/grub && echo "grub is OK!"

sudo grub-mkconfig -o /boot/grub/grub.cfg && echo "grub is update!"

#---------~./vimrc and ~/.bashrc --------------
echo "set tabstop=4" >> ~/.vimrc && echo '.vimrc is OK'

. ~/.vimrc && echo '.vimrc is update'

echo "PS1='[\[\e[32m\]\[\e[31m\]\u@\[\e[36m\]\h \w]\$\[\e[m\]'" >> ~/.bashrc && echo ".bashrc is OK!"
sed -i "s/alias ll='ls -alF'/alias ll='ls -lF'/" ~/.bashrc && echo "ll is OK!"
. ~/.bashrc && echo ".bashrc is update!"

#-----------networking setting -----------------
sudo cat > /etc/network/interfaces <<EOF
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback

# The primary network interface
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
address 192.168.xx.xx
netmask 255.255.255.0
broadcast 192.168.xx.255
EOF
#----------------------------------------------
