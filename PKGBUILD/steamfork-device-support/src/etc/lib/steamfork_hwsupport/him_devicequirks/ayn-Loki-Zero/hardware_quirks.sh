#!/bin/bash
export STEAMFORK_GAMESCOPE_ADDITIONAL_OPTIONS="--force-orientation left"
export STEAMFORK_GAMESCOPE_RES="-W 1280 -h 720 -w 1280 -h 720"
export STEAMFORK_X11_ROTATION="left"
export STEAMFORK_GRUB_ADDITIONAL_CMDLINEOPTIONS="radeon.modeset=1 copytoram=n nvme_load=yes amd_pstate=active amd_pstate.shared_mem=1 amdgpu.dpm=1 amdgpu.gpu_recovery=1 iomem=relaxed"
