#!/bin/bash
# mount ssd
for i in b c d;
do

echo "mount /dev/sd${i}"
mkdir -p /mnt/sd$i

mount /dev/sd${i}1 /mnt/sd$i

done