#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Fewtarius

WIFI_BACKEND=$(/usr/bin/steamos-wifi-set-backend --check 2>/dev/null)
if [ ! "${WIFI_BACKEND}" = "wpa_supplicant" ] && \
   (( $? = 0 ))
then
	/usr/bin/steamos-wifi-set-backend wpa_supplicant
fi
