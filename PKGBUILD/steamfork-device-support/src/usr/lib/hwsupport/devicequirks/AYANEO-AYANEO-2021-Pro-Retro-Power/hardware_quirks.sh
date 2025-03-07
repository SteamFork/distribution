#!/bin/bash
export X11_ROTATION=inverted
export GAMESCOPE_RES="-w 1280 -h 800"
export GAMESCOPE_ADDITIONAL_OPTIONS="--force-orientation upsidedown"
export STEAMFORK_GRUB_ADDITIONAL_CMDLINEOPTIONS+=" module_blacklist=ayaneo_platform"
