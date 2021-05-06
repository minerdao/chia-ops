#!/bin/bash
# disable ufw
currentUser=chia

systemctl stop ufw
systemctl disable ufw

# install dep
apt update
apt install -y net-tools tree openssh-server

# vim line
echo "set number" >> ~/.vimrc

# sudoers config
cat >>/etc/sudoers <<FFF
chia ALL=(ALL:ALL) ALL
FFF

# ntp update
apt install ntpdate -y
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
ntpdate ntp.aliyun.com

# setup chia env
echo 'source /home/chia/chia-blockchain/activate' >> ~/.profile

# setup alias
echo "# chia alias" >> ~/.profile
echo 'alias status="plotman status"' >> ~/.profile
echo 'alias summary="chia farm summary"' >> ~/.profile
source ~/.profile
