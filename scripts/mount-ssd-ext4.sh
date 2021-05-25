#!/bin/bash

# mount ssd
for i in {0..3};
do

mkfs.ext4 /dev/nvme${i}n1p1
echo "/dev/nvme${i}n1p1 parted"

mkdir -p /mnt/tmp/ssd$i
mount /dev/nvme${i}n1p1 /mnt/tmp/ssd$i
echo "/dev/nvme${i}n1p1 mounted"

done