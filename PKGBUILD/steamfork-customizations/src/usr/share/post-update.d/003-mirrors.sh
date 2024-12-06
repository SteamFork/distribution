#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Fewtarius

source /etc/os-release

rm -f /etc/pacman.d/steamfork-mirrorlist
steamfork-get-mirror random | while read line
do
  echo "Server = https://${line}/repos/${STEAMOS_VERSION}" >>/etc/pacman.d/steamfork-mirrorlist
done
