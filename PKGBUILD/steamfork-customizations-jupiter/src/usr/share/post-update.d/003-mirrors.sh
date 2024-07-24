#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Fewtarius

rm -f /etc/pacman.d/steamfork-mirrorlist
steamfork-get-mirror random | while read line
do
  echo "Server = ${line}/repos/rel" >>/etc/pacman.d/steamfork-mirrorlist
done
