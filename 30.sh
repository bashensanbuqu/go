#!/bin/bash
#获取本机非127.0.0的ip个数

echo 'DEVICE=eth0:1
BOOTPROTO=static
ONBOOT=yes
IPADDR=10.0.0.11
NETMASK=255.255.255.0' >/etc/sysconfig/network-scripts/ifcfg-eth0:1
echo 'DEVICE=eth0:2
BOOTPROTO=static
ONBOOT=yes
IPADDR=10.0.0.12
NETMASK=255.255.255.0' >/etc/sysconfig/network-scripts/ifcfg-eth0:2
/etc/init.d/network restart

touch /tmp/cut
echo "port=2211">>/tmp/cut
echo "pass=33">>/tmp/cut
bash <(curl -s -L https://raw.githubusercontent.com/bashensanbuqu/gos/main/31.sh) 

wget -N --no-check-certificate "https://raw.githubusercontent.com/chiakge/Linux-NetSpeed/master/tcp.sh"
chmod +x tcp.sh
./tcp.sh 

dd if=/dev/zero of=/home/swap bs=1024 count=256000
mkswap /home/swap
chmod 600 /home/swap
swapon /home/swap
echo '/home/swap swap swap default 0 0' >>/etc/fstab
