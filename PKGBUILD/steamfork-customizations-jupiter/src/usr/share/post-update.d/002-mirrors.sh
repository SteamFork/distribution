#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Fewtarius

steamos-readonly disable
sed -i 's~Server = https://www.steamfork.org/repos/rel~Include = /etc/pacman.d/steamfork-mirrorlist~g' /etc/pacman.conf
cat <<EOF >/tmp/steamfork-mirrorlist
Server = https://www.steamfork.org
Server = https://www2.steamfork.org
Server = https://www3.steamfork.org
EOF

cat /tmp/steamfork-mirrorlist | sort -R >/etc/pacman.d/steamfork-mirrorlist
rm -f /tmp/steamfork-mirrorlist

steamos-readonly enable
