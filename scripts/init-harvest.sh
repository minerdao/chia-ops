#!/bin/bash
apt install -y net-tools tree sysstat

# vim line
echo "set number" > ~/.vimrc

# sudoers config
cat >>/etc/sudoers <<FFF
chia ALL=(ALL:ALL) ALL
FFF

# ntp update
apt install ntpdate -y
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ntpdate ntp.aliyun.com