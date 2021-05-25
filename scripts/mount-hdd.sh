#!/bin/bash

currentUser=chia

# mount ssd
# for i in b c d e f g h i j k;
# for i in c d e f;
for i in b c d e;
do

mkfs.ext4 /dev/sd${i}1
echo "/dev/sd${i} parted"

mkdir -p /mnt/dst/sd$i
mount /dev/sd${i}1 /mnt/dst/sd$i
echo "/dev/sd${i} mounted"

done

# change mnt mode
echo "chown mnt points"
chown -R $currentUser:$currentUser /mnt