#!/bin/bash

mkdir /etc/yum.repos.d/tmp
mv /etc/yum.repos.d/* /etc/yum.repos.d/tmp &> /dev/null 
touch /etc/yum.repos.d/own.repo

mkdir /mnt/cdrom

cat > /etc/yum.repos.d/base.repo <<EOF
[base]
name=base
baseurl=file:///mnt/cdrom/
gpgcheck=0
EOF


echo "/dev/sr0	/mnt/cdrom   iso9660    defaults    0 0" >> /etc/fstab &>/dev/null
mount -a &>/dev/null

yum clean all &> /dev/null
yum repolist &> /dev/null 

yum install vim -y &> /dev/null; echo "vim OK"


cat > /root/.vimrc <<EOF
set ignorecase
set cursorline
set tabstop=4
autocmd BufNewFile *.sh exec ":call SetTitle()"
func SetTitle()
            if expand("%:e") == 'sh'
            call setline(1,"#!/bin/bash")
            call setline(2,"#")
            call setline(3,"#******************************************")
            call setline(4,"#Author:            杜肇启   ")
            call setline(5,"#QQ:                3206219607")
            call setline(6,"#Date:              ".strftime("%Y-%m-%d"))
            call setline(7,"#Filename:          ".expand("%"))
            call setline(8,"#******************************************")                            
            endif
endfunc
autocmd BufNewFile * normal G
EOF
.  ~/.vimrc &>/dev/null


yum install openssh-clients -y &>/dev/null
