#!/bin/bash
# mkfs & mount hdd

for i in b c d e;
# for i in b c d e f g h i j k;
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

done