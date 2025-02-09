#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2025 SteamFork (https://github.com/SteamFork)

source steamfork-devicequirk-set

if [ -n "${ROTATE_DIGITIZER[0]}" ]
then
	if [ -f "/etc/X11/xorg.conf.d/99-touchscreen_orientation.conf" ]
	then
		rm -f "/etc/X11/xorg.conf.d/99-touchscreen_orientation.conf"
	fi
	for DIGITIZER in "${ROTATE_DIGITIZER[@]}"
	do
		EVENT_DEVICE="${DIGITIZER%:*}"
		CALIBRATION="${DIGITIZER#*:}"
		case ${CALIBRATION} in
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
			*)
				X11_TOUCH="${CALIBRATION}"
				;;
		esac
	
		cat <<EOF | sudo tee -a /etc/X11/xorg.conf.d/99-touchscreen_orientation.conf
Section "InputClass"
	Identifier "Coordinate Transformation Matrix"
	MatchIsTouchscreen "on"
	MatchDevicePath "${EVENT_DEVICE}"
	MatchDriver "libinput"
	Option "CalibrationMatrix" "${X11_TOUCH}"
EndSection
EOF
	done
else
	if [ -f "/etc/X11/xorg.conf.d/99-touchscreen_orientation.conf" ]
	then
		rm -f "/etc/X11/xorg.conf.d/99-touchscreen_orientation.conf"
	fi
fi
