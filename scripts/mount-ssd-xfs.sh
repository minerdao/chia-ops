#!/bin/bash

# mount ssd
for i in {0..3};
do

mkfs.xfs -f -d agcount=128,su=128k,sw=2 -r extsize=256k /dev/nvme${i}n1p1
echo "/dev/nvme${i}n1p1 parted"

mkdir -p /mnt/tmp/ssd$i
mount -t xfs /dev/nvme${i}n1p1 /mnt/tmp/ssd$i
echo "/dev/nvme${i}n1p1 mounted"

done