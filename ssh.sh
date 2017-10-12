#!/bin/bash
#all0shell.org
#功能:实现防ssh暴力破解
cat /var/log/secure|awk '/Failed/{print $(NF-3)}'|sort|uniq -c|awk '{print $2"=" $1;}' > /tmp/hack-ssh.txt //查看Linux登录日志 输出
DEFINE="10"//登录错误10次
for i in `cat /tmp/hack-ssh.txt`
do 
        IP=`echo $i|awk -F= '{print $1}'`
        NUM=`echo $i|awk -F= '{print $2}'`
        if [ $NUM -gt $DEFINE ]
        then
                grep $IP /etc/hosts.deny >/dev/null //看看ip是否存在
                if [ $? -gt 0 ]; //若不存在，则执行下面的语句
                then
                echo "sshd:$IP" >> /etc/hosts.deny 
                fi
        fi
done
