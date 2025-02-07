#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025 SteamFork (https://github.com/SteamFork)

source steamfork-devicequirk-set

if [ "${ROTATE_DIGITIZER}" = "true" ]
then
	case ${X11_ROTATION} in
		left)
			X11_TOUCH="0 -1 1 1 0 0 0 0 1"
			;;
		right)
			X11_TOUCH="0 1 0 -1 0 1 0 0 1"
			;;
		normal)
			X11_TOUCH="1 0 0 0 1 0 0 0 1"
			;;
		inverted)
			X11_TOUCH="-1 0 1 0 -1 1 0 0 1"
			;;
	esac

	cat <<EOF | sudo tee /etc/X11/xorg.conf.d/99-touchscreen_orientation.conf
Section "InputClass"
	Identifier "Coordinate Transformation Matrix"
	MatchIsTouchscreen "on"
	MatchDevicePath "/dev/input/event*"
	MatchDriver "libinput"
	Option "CalibrationMatrix" "${X11_TOUCH}"
EndSection
EOF
else
	if [ -f "/etc/X11/xorg.conf.d/99-touchscreen_orientation.conf" ]
	then
		rm -f "/etc/X11/xorg.conf.d/99-touchscreen_orientation.conf"
	fi
fi
