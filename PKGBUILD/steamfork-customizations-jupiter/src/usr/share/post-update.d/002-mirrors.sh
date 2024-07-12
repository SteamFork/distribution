#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Fewtarius

steamos-readonly disable
sed -i 's~Server = https://www.steamfork.org/repos/rel~Include = /etc/pacman.d/steamfork-mirrorlist~g' /etc/pacman.conf
steamfork-get-mirror random | while read line
do
  echo "Server = ${line}" >>/etc/pacman.d/steamfork-mirrorlist
done
steamos-readonly enable
