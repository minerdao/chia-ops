#!/bin/bash

# mount ssd
for i in {0..3};
do

mkdir -p /mnt/ssd$i
mount -t xfs /dev/nvme${i}n1p1 /mnt/ssd$i
echo "/dev/nvme${i}n1p1 mounted"
done