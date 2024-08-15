#!/bin/bash
export X11_ROTATION=left
export X11_TOUCH="0 -1 1 1 0 0 0 0 1"
export GAMESCOPE_RES="-W 1280 -H 720 -w 1280 -h 720"
export GAMESCOPE_ADDITIONAL_OPTIONS="--force-orientation left"
export STEAMFORK_GRUB_ADDITIONAL_CMDLINEOPTIONS="copytoram=n nvme_load=yes amd_pstate=active initcall_blacklist=acpi_cpufreq_init amd_pstate.shared_mem=1 amdgpu.dpm=1 amdgpu.gpu_recovery=1 iomem=relaxed spi_amd.speed_dev=1 pcie_aspm=force module_blacklist=tpm log_buf_len=4M audit=0 fbcon=nodefer"
