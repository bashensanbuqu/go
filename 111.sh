#!/bin/bash
sudo sed -i 's/^.*PermitRootLogin.*/PermitRootLogin yes/g' /etc/ssh/sshd_config
sudo sed -i 's/^.*PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
echo root:yourRootPasswd | sudo chpasswd
sudo service ssh restart
touch 1.sh
