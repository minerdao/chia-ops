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

echo "mkfs /dev/nvme${i}n1p1"
mkfs.xfs -f -d agcount=128,su=128k,sw=2 -r extsize=256k /dev/nvme${i}n1p1

done