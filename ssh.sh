#!/bin/bash
#all0shell.org
cat /var/log/secure|awk '/Failed/{print $(NF-3)}'|sort|uniq -c|awk '{print $2"=" $1;}' > /tmp/hack-ssh.txt //�鿴Linux��¼��־ ���
DEFINE="10"//��¼����10��
for i in `cat /tmp/hack-ssh.txt`
do 
        IP=`echo $i|awk -F= '{print $1}'`
        NUM=`echo $i|awk -F= '{print $2}'`
        if [ $NUM -gt $DEFINE ]
        then
                grep $IP /etc/hosts.deny >/dev/null //����ip�Ƿ����
                if [ $? -gt 0 ]; //�������ڣ���ִ����������
                then
                echo "sshd:$IP" >> /etc/hosts.deny 
                fi
        fi
done
