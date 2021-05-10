#!/bin/bash
# mkfs & mount hdd
for i in b c d;
do
parted -a optimal /dev/sd${i} <<EOF
  rm 1
  rm 2
  rm 3
  mklabel gpt
  mkpart primary ext4 0% 100%
  ignore
  quit
EOF
echo "/dev/sd${i}1 created"

sleep 1s

echo "mkfs /dev/sd${i} as ext4..."
mkfs.ext4 /dev/sd${i}1

done

# change mnt mode
echo "chown mnt points"
chown -R $currentUser:$currentUser /mnt
