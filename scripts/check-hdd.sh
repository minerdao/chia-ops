#!/usr/bin/env bash

echo "$(fdisk -l | grep "14.6 TiB" | sort -k2)"