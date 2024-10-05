#!/bin/sh
# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2024-present Fewtarius

### Work around for the /var/run is a directory bug that sometimes appears
### until it can be resolved in whichever package breaks it.
if [ -d "/var/run" ]
then
	rm -rf /var/run
	ln -sf /run /var/run
fi
