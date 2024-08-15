#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Fewtarius

### Correct the touchscreen orientation.
source steamfork-devicequirk-set

if [ -n "${X11_TOUCH}" ]
then
	sed -i 's~Option "CalibrationMatrix" ".*$~Option "CalibrationMatrix" "'${X11_TOUCH}'"~g' /etc/X11/xorg.conf.d/99-touchscreen_orientation.conf
fi
