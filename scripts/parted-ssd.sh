#!/bin/bash

# mkfs & mount ssd
for i in {0..3};
do

parted -a optimal /dev/nvme${i}n1 <<EOF
  rm 1
  rm 2
  rm 3
  rm 4
  mklabel gpt
  mkpart primary ext4 0% 100%
  ignore
  quit
EOF

done