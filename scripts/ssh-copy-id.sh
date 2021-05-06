#!/usr/bin/env bash
for i in h{10..90};
do
  ssh-keyscan $i >> ~/.ssh/known_hosts
  ssh-copy-id $i
done
