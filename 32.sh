#!/bin/bash
echo “同步网络时间中…”
yum install -y ntpdate
ntpdate -u cn.pool.ntp.org
#ntpdate time.nuri.net
hwclock -w
mv /etc/localtime /etc/localtime.bak
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
date -R

if ps -ef|grep "gost"|egrep -v grep >/dev/null
then
 ps -ef|grep gost|grep -v grep|awk '{print $2}'|xargs kill -9
else
    echo -e "\033[32m"Ha Ha 来吧来吧！！"\033[0m"
fi

if [ -f "/etc/rc.d/init.d/ci_gost" ];then
    rm -fr /etc/rc.d/init.d/ci_gost
else
    echo -e "\033[32m"一切才刚刚开始！！！"\033[0m"
fi

if [ -f "/tmp/s5" ];then
    rm -fr /tmp/s5
else
    echo -e "\033[32m"如果耐不住寂寞，你就看不到繁华"\033[0m"
fi

if [ -d "/usr/local/gost" ];then
    rm -fr /usr/local/gost&&mkdir -p /usr/local/gost
else
    echo "长江之水天上来，奔流到海不复回！"&&mkdir -p /usr/local/gost
fi

rpm -qa|grep "wget" &> /dev/null
if [ $? == 0 ]; then
    echo 亲多喝水对身体有好处哦！！
else
    yum -y install wget
fi

num=`at -l| awk -F ' ' '{print $1}'`&&at -d $num #取消任务

wget --no-check-certificate  -P /tmp https://raw.githubusercontent.com/bashensanbuqu/gs/main/gost.tar.gz

if [[ ! -f "/tmp/gost.tar.gz" ]]; then
 echo -e "\033[41m"下载失败请检查网络，或者联系脚本作者 WX：com117idc "\033[0m"&&set -e
else
 echo 再等等吧！ 就要好了！！！
fi

tar -zmxf /tmp/gost.tar.gz -C /usr/local/gost/
mv -f /usr/local/gost/ci_gost /etc/rc.d/init.d/ci_gost
mv -f /usr/local/gost/un_gost /etc/rc.d/init.d/un_gost
chmod +x /usr/local/gost/gost
chmod +x /etc/rc.d/init.d/ci_gost
chmod +x /etc/rc.d/init.d/un_gost

#先检查是否安装了iptables
rpm -qa|grep "iptables" &> /dev/null
if [ $? == 0 ]; then
    echo -e "\033[33m时钟滴答滴答不停转动！！！\033[0m"
else
    yum install -y iptables> /tmp/log.log;
fi 

#安装iptables-services
rpm -qa|grep "iptables-services" &> /dev/null
if [ $? == 0 ]; then
    echo -e "\033[33m别催，别催，该来的我不推！！！\033[0m"
else
    yum install iptables-services -y> /tmp/log.log
fi

yum update iptables> /tmp/log.log; #升级 iptables

if ps -ef|grep "firewalld"|egrep -v grep >/dev/null
then
   systemctl stop firewalld&&systemctl mask firewalld> /tmp/log.log; #停止并禁用firewalld服务
else
   echo -e "\033[32m我就是这样想你，念你，却也不打扰你。\033[0m"
fi

systemctl enable iptables.service&&systemctl start iptables.service&&iptables -P INPUT ACCEPT> /tmp/log.log; #开启iptables服务 
iptables -t nat -F&&iptables -t nat -P OUTPUT ACCEPT&&iptables -t nat -P POSTROUTING ACCEPT> /tmp/log.log;
iptables -t nat -P PREROUTING ACCEPT&&iptables -t nat -X&&iptables -t mangle -F> /tmp/log.log;
iptables -t mangle -X&&iptables -P OUTPUT ACCEPT&&iptables -t mangle -P INPUT ACCEPT> /tmp/log.log;
iptables -t mangle -P FORWARD ACCEPT&&iptables -t mangle -P OUTPUT ACCEPT&&iptables -F> /tmp/log.log;
iptables -t mangle -P POSTROUTING ACCEPT&&iptables -P FORWARD ACCEPT&&iptables -X> /tmp/log.log;
iptables -P INPUT ACCEPT&&iptables -t raw -F&&iptables -t mangle -P PREROUTING ACCEPT> /tmp/log.log;
iptables -t raw -X&&iptables -t raw -P PREROUTING ACCEPT&&iptables -t raw -P OUTPUT ACCEPT> /tmp/log.log;

v=`ip addr|grep -o -e 'inet [0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}'|grep -v "127.0.0"|awk '{print $2}'| wc -l` #获取本机非127.0.0的ip个数
ip addr|grep -o -e 'inet [0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}.[0-9]\{1,3\}'|grep -v "127.0.0"|awk '{print $2}'> /tmp/ip.txt
lip=`sed -n ''1'p' /tmp/ip.txt`&&wip=`curl ipv4.icanhazip.com`;
port=`grep "port" /tmp/cut|awk -F '=' '{print $2}'`; pass=`grep "pass" /tmp/cut|awk -F '=' '{print $2}'`; rm -fr /tmp/cut
if [ ! -n "$port" ]; then port=`shuf -i30000-60000 -n1`; else port=$port; fi; base=`shuf -i1000-2900 -n1`0

if [ "$v" -gt "1" ];then  
    echo -e "\033[33m"这就是传说中的多ip出口服务器"  \033[0m" 
#检查用户是否存在，不存在则创建用户
for i in `seq $v`;
do
if id -u aa$i>/dev/null 2>&1; then
    echo -e "\033[32m"等待也是一种享受 !!!$i" \033[0m" 
else
    pw=$(tr -dc "0-9a-zA-Z" < /dev/urandom | head -c 12)> /tmp/log.log;
    useradd "aa$i"&& echo -e "\033[35m "等待也是一种享受...$i" \033[0m";
    #echo "$pw" |passwd --stdin aa$i> /tmp/sar.log;
    #echo "aa$i    ALL=(ALL)    ALL" >> /etc/sudoers  
fi
done

#用户UID绑定IP出口
uid=`awk -F: '/^aa1:/{print $4,$5}' /etc/passwd`
uip=$[ $uid-1 ]
for i in `seq $v`;
do
iptables -t mangle -A OUTPUT -m owner --uid-owner $[ $i+$uip ] -j MARK --set-mark $[ $i+$uip ]> /tmp/log.log;
iptables -t nat -A POSTROUTING -m mark --mark $[ $i+$uip ] -j SNAT --to-source `sed -n ''$i'p' /tmp/ip.txt`> /tmp/log.log;
done

for i in `seq $v`;
do
  if [ ! -n "$pass" ]; then   s5pw=$(tr -dc "0-9a-zA-Z" < /dev/urandom | head -c 2)> /tmp/log.log; else s5pw=$pass; fi
  echo "su  aa$i -c "\""/usr/local/gost/gost -D -L=$s5pw:$s5pw@`sed -n ''$i'p' /tmp/ip.txt`:$port?timeout=30 &"\""">>/etc/rc.d/init.d/ci_gost
#  echo "方式一：<$wip:$[ $i+2110 ]:$s5pw:$s5pw>	方式二：<`sed -n ''$i'p' /tmp/ip.txt`:$port:$s5pw:$s5pw>">>/tmp/s5;
   echo "$wip/$[ $i+2110 ]/$s5pw/$s5pw">>/tmp/s5

done


#端口映射
for i in `seq $v`;
do
iptables -t nat -A PREROUTING -d $lip -p tcp --dport $[ $i+2110 ] -j DNAT --to-destination `sed -n ''$i'p' /tmp/ip.txt`:$port> /tmp/log.log;
iptables -t nat -A PREROUTING -d $lip -p udp --dport $[ $i+2110 ] -j DNAT --to-destination `sed -n ''$i'p' /tmp/ip.txt`:$port> /tmp/log.log;
iptables -t nat -A PREROUTING -p udp --dst `sed -n ''$i'p' /tmp/ip.txt` -j DNAT --to-destination $lip> /tmp/log.log;
done

else
  echo -e "\033[33m"单ip出口服务器......" \033[0m" ;
  if [ ! -n "$pass" ]; then   s5pw=$(tr -dc "0-9a-zA-Z" < /dev/urandom | head -c 2)> /tmp/log.log; else s5pw=$pass; fi
  useradd "aa1"
  echo "su  aa1 -c "\""/usr/local/gost/gost -D -L=$s5pw:$s5pw@$lip:$port?timeout=30 &"\""">>/etc/rc.d/init.d/ci_gost
  echo "$wip/$port/$s5pw/$s5pw">>/tmp/s5
fi 

if [[ $(iptables-save -t nat) =~ MASQUERADE ]]; then     echo ".."; else     iptables -t nat -A POSTROUTING -j MASQUERADE> /tmp/log.log; fi
service iptables save> /tmp/log.log; echo 1 >/proc/sys/net/ipv4/ip_forward;sysctl -p> /tmp/log.log 
ulimit -SHn 10240&&ulimit -SHs unlimited&&echo 500000 >/proc/sys/net/nf_conntrack_max
rm -fr /tmp/ip.txt&&rm -fr /tmp/gost.tar.gz&&rm -fr /tmp/log.log&&chmod +x /etc/rc.local

useradd a1
echo 'su  a1 -c "/usr/local/gost/gost -D -L=ss://nane:33@10.0.0.4:2233?timeout=30 &"' >>/etc/rc.d/init.d/ci_gost
echo 'su  a1 -c "/usr/local/gost/gost -D -L=ssu://nane:33@10.0.0.4:2233?timeout=30 &"' >>/etc/rc.d/init.d/ci_gost

source /etc/rc.d/init.d/ci_gost  t.txt >/dev/null 2>&1
if cat '/etc/rc.local' | grep "/etc/rc.d/init.d/ci_gost" > /dev/null ;then
  echo '金黄的落叶堆满我心间，我已不再是青春少年。'
else
  echo /etc/rc.d/init.d/ci_gost>>/etc/rc.local
fi

yum -y install at&&chkconfig --level 35 atd on&&service atd start> /tmp/log.log;
