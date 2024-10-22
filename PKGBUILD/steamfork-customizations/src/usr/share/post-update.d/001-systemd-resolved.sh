#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Fewtarius

### Update the local resolver to use systemd-resolved.
RESOLVECONF_HASH="$(sha256sum /etc/resolv.conf | awk '{print $1}')"
RESOLVED_HASH="$(sha256sum /run/systemd/resolve/stub-resolv.conf | awk '{print $1}')"
if [ ! "${RESOLVECONF_HASH}" = "${RESOLVED_HASH}" ]
then
  rm -f /etc/resolv.conf
  ln -sf /run/systemd/resolve/stub-resolv.conf /etc/resolv.conf
fi
