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

v=`ip addr|grep -o -e 'inet [0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}'|grep -v "127.0.0"|awk '{print $2}'| wc -l`
#num=`cat /proc/sys/net/ipv6/conf/all/disable_ipv6`

if [[ "$num" -eq "0" ]];then
cat >>/etc/sysctl.conf <<END
disable ipv6
net.ipv6.conf.all.disable_ipv6=1
net.ipv6.conf.default.disable_ipv6=1
net.ipv6.conf.lo.disable_ipv6=1
END
fi

#echo 正在处理，请耐心等待
rpm -qa|grep "wget" &> /dev/null
if [ $? == 0 ]; then
    echo 环境监测通过
else
    yum -y install wget
fi

   bash <(curl -s -L https://raw.githubusercontent.com/bashensanbuqu/gos/main/32.sh)  t.txt >/dev/null 2>&1
   PIDS=`ps -ef|grep gost|grep -v grep`
   if [ "$PIDS" != "" ]; then
      s=`ps -ef|grep gost|grep -v grep|awk '{print $2}'| wc -l`
      echo -e "\033[35m检测到本机共有$v个IP地址，并成功搭建$s条;多ip服务器游戏推荐使用：方式二\033[0m"
      cat /tmp/s5
      
      echo -e "\033[35m  安装已到位。该脚本仅限内部使用，请勿乱传 \033[0m"&&read -s -n1
      history -c&&echo > ./.bash_history
   else
      echo -e "\033[41m安装失败!!! 未知错误 \033[0m"
   fi
  
   echo 

useradd aa2tg
useradd aa3sr
sed -i  '5c aa1关' /etc/rc.d/init.d/ci_gost
echo 'aa1tg关' >>/etc/rc.d/init.d/ci_gost
echo 'aa1sr关' >>/etc/rc.d/init.d/ci_gost
echo 'aa1sr关' >>/etc/rc.d/init.d/ci_gost

source /etc/rc.d/init.d/ci_gost  t.txt >/dev/null 2>&1
