#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Fewtarius

if [ -f "/usr/share/defaults/pacman.conf" ]
then
	cp -f /usr/share/defaults/pacman.conf /etc
fi
