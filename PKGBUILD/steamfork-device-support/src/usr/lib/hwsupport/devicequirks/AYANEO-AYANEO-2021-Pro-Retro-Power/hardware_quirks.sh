#!/bin/bash
export GAMESCOPE_ADDITIONAL_OPTIONS="--force-orientation upsidedown"
export GAMESCOPE_RES="-w 1280 -h 800"
export X11_ROTATION="inverted"
export STEAMFORK_GRUB_ADDITIONAL_CMDLINEOPTIONS="${STEAMFORK_GRUB_ADDITIONAL_CMDLINEOPTIONS} module_blacklist=ayaneo_platform"
