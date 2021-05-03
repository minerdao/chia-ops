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

# setup alias
echo "# chia alias" >> ~/.profile
echo "alias status=plotman status" >> ~/.profile
echo "alias summary=chia farm summary" >> ~/.profile
source ~/.profile

# mkfs & mount ssd
for i in {0..3};
do
ssd=/dev/nvme${i}n1
echo $ssd
parted -a optimal $ssd <<EOF
  mklabel gpt
  mkpart primary ext4 0% 20%
  ignore
  quit
EOF
echo "${ssd}p1 created"

parted -a optimal $ssd <<EOF
  mklabel gpt
  mkpart primary ext4 20% 40%
  ignore
  quit
EOF
echo "${ssd}p2 created"

parted -a optimal $ssd <<EOF
  mklabel gpt
  mkpart primary ext4 40% 60%
  ignore
  quit
EOF
echo "${ssd}p3 created"

parted -a optimal $ssd <<EOF
  mklabel gpt
  mkpart primary ext4 60% 80%
  ignore
  quit
EOF
echo "${ssd}p4 created"

parted -a optimal $ssd <<EOF
  mklabel gpt
  mkpart primary ext4 80% 100%
  ignore
  quit
EOF
echo "${ssd}p5 created"

sleep 1s

  for j in {1..5};
    echo "mkfs ${ssd}/p${j} as ext4..."
    mkfs.ext4 $ssd/p$j
    echo "mount ${ssd}/p${j}"
    mkdir -p /mnt/ssd$i$j
    mount $ssd/p$j /mnt/ssd$i$j
  done
done

# mkfs & mount hdd
for i in b c d;
do
hdd=/dev/sd${i}
echo $hdd
parted -a optimal $hdd <<EOF
  rm 1
  rm 2
  rm 3
  mklabel gpt
  mkpart primary ext4 0% 100%
  ignore
  quit
EOF
echo "${hdd} was fdisked"

sleep 1s

echo "mkfs ${hdd} as ext4..."
mkfs.ext4 $hdd

echo "mount ${hdd}"
mkdir -p /mnt/sd${i}
mount $hdd /mnt/sd${i}
done

# change mnt mode
echo "chown mnt points"
chown -R $currentUser:$currentUser /mnt

# init harvest
