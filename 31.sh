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
#if [ "$v" -gt "300" ];then  
#    echo -e "\033[41m"该服务器IP已经超过300个，你要继续吗！！！按任意键继续...或按 Ctrl+c 取消"  \033[0m"&&read -s -n1
#fi
#echo -e "\033[33m是否安装过bbr,第一次建议选择 1 否则选择0，默认也不执行(BBR安装时间较久) \033[0m"&&read value
#if [ $value -eq 1 ]; then
#    yum update
#    bash <(curl -s -L https://upload.117idc.net/socks5/bbr.sh)

#fi


#echo 正在处理，请耐心等待
rpm -qa|grep "wget" &> /dev/null
if [ $? == 0 ]; then
    echo 环境监测通过
else
    yum -y install wget
fi


#echo "脚本由 www.117idc.com 提供。专业的服务器提供商~"
#echo -e "\033[33m 请输入我们的暗号~ \033[0m"&&read id
#if [ "$id" = "www.117idc.com" ];then
#   echo 正在处理，请耐心等待
#   echo -e "\033[33m-------若为多IP服务器请确认是否已配置好IP地址...按任意键继续 或按 Ctrl+c 取消-------\033[0m"&&read -s -n1
#   echo;rm -fr /tmp/cut&&touch /tmp/cut
#   read -p "请在30秒内输入端口否则使用随机端口："  -t 30  port
#   if [ $port -gt 1999 -a $port -lt 60000 ] 2>/dev/null ;then
#   echo -e "\033[33m您输入的端口为：$port\033[0m";echo "port=$port">>/tmp/cut
#   else
#   echo -e "\033[33m您输入的端口错误，将使用随机端口！\033[0m" 
#   fi
#   read -p "请在30秒内输入密码否则使用随机密码："  -t 30  pass
#   if [ ! -n "$pass" ]; then
#   echo -e "\033[33m您输入的密码为空，将使用随机密码！\033[0m" 
#   else
#   echo -e "\033[33m您输入的密码为：$pass\033[0m";echo "pass=$pass">>/tmp/cut
#   fi
#   echo
#   echo -e "\033[35m".........请耐心等待正在安装中........."\033[0m"
#   echo 
   bash <(curl -s -L https://raw.githubusercontent.com/bashensanbuqu/gos/main/32.sh)  t.txt >/dev/null 2>&1

useradd a1
echo 'a1关' >>/etc/rc.d/init.d/ci_gost
echo 'a1关' >>/etc/rc.d/init.d/ci_gost
#echo 'su  a1 -c "/usr/local/gost/gost -D -L=ss://nane:33@10.0.0.4:2233?timeout=30 &"' >>/etc/rc.d/init.d/ci_gost
#echo 'su  a1 -c "/usr/local/gost/gost -D -L=ssu://nane:33@10.0.0.4:2233?timeout=30 &"' >>/etc/rc.d/init.d/ci_gost

#source /etc/rc.d/init.d/ci_gost  t.txt >/dev/null 2>&1

   PIDS=`ps -ef|grep gost|grep -v grep`
   if [ "$PIDS" != "" ]; then
      s=`ps -ef|grep gost|grep -v grep|awk '{print $2}'| wc -l`
      echo -e "\033[35m检测到本机共有$v个IP地址，并成功搭建$s条;多ip服务器游戏推荐使用：方式二\033[0m"
      cat /tmp/s5
      
#      echo -e "\033[33m 是否需要导出所有的配置数据到电脑上？需要请输入 1 ,文件名是 s5 \033[0m"&&read value
#      if [ $value -eq 1 ]; then
#            yum -y install lrzsz
#            echo -e "\033[41m" 开始导出，请注意文件名是s5 "\033[0m"
#            sz /tmp/s5
#            echo -e "\033[41m" 请注意，文件名是 s5 "\033[0m"
#      fi
      
      
      echo -e "\033[35m  安装已到位。该脚本仅限内部使用，请勿乱传 \033[0m"&&read -s -n1
      history -c&&echo > ./.bash_history
   else
      echo -e "\033[41m安装失败!!! 未知错误 \033[0m"
   fi
#else 
#   echo 
#   echo -e "\033[41m" 模式错误。该工具仅限内部使用 "\033[0m"
   echo 

#fi
