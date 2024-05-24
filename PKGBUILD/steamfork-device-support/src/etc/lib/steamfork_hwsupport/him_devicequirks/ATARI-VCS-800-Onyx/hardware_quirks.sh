#!/bin/bash
export STEAMFORK_GAMESCOPE_RES="-W 1280 -H 720 -w 1280 -h 720"
export STEAMFORK_GRUB_ADDITIONAL_CMDLINEOPTIONS="radeon.modeset=1 copytoram=n nvme_load=yes amdgpu.dpm=1 amdgpu.gpu_recovery=1 amdgpu.runpm=0 iomem=relaxed"
