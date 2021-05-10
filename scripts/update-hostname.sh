#!/usr/bin/env bash

hostname=$1
sed -i "s/fil/${hostname}/g" /etc/hosts
sed -i "s/fil/${hostname}/g" /etc/hostname