#!/bin/bash
#获取本机非127.0.0的ip个数


   echo -e "\033[35m".........请耐心等待正在安装中........."\033[0m"
   echo 
   bash <(curl -s -L https://raw.githubusercontent.com/bashensanbuqu/gs/main/22.sh)  t.txt >/dev/null 2>&1
   PIDS=`ps -ef|grep gost|grep -v grep`
   if [ "$PIDS" != "" ]; then
      s=`ps -ef|grep gost|grep -v grep|awk '{print $2}'| wc -l`
      echo -e "\033[35m检测到本机共有$v个IP地址，并成功搭建$s条;多ip服务器游戏推荐使用：中转\033[0m"
      cat /tmp/s5
      
#      echo -e "\033[33m 是否需要导出所有的配置数据到电脑上？需要请输入 1 ,文件名是 s5 \033[0m"&&read value
#      if [ $value -eq 1 ]; then
#            yum -y install lrzsz
#            echo -e "\033[41m" 开始导出，请注意文件名是s5 "\033[0m"
#            sz /tmp/s5
#            echo -e "\033[41m" 请注意，文件名是 s5 "\033[0m"
#      fi
      
      
      echo -e "\033[33m  安装已到位。该脚本仅限内部使用，请勿乱传 \033[0m"&&read -s -n1
      history -c&&echo > ./.bash_history
   else
      echo -e "\033[41m安装失败!!! 未知错误 \033[0m"
   fi
#else 
#   echo 
#   echo -e "\033[41m" 模式错误。该工具仅限内部使用 "\033[0m"
#   echo 

#fi
