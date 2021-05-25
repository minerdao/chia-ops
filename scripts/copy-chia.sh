#!/usr/bin/env bash
for i in h64;
do
  rsync -ah --progress /home/chia/chia/chia-blockchain chia@$i:~/chia/
done