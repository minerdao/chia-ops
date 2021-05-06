#!/bin/bash

# mount ssd
for i in {0..3};
do

mkdir -p /mnt/ssd$i

sleep 3

mount /dev/nvme${i}n1p1 /mnt/ssd$i
done