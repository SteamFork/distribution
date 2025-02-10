#!/bin/bash
export X11_ROTATION="left"
export GAMESCOPE_RES="-w 1280 -h 720"
export GAMESCOPE_ADDITIONAL_OPTIONS="--force-orientation left"
export ROTATE_DIGITIZER=("/dev/input/event*:${X11_ROTATION}")
