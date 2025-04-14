#!/bin/bash
export GAMESCOPE_ADDITIONAL_OPTIONS="--force-orientation left"
export GAMESCOPE_RES="-w 1280 -h 720"
export ROTATE_DIGITIZER=("/dev/input/event*:${X11_ROTATION}")
export X11_ROTATION="left"
