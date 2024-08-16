#!/bin/bash
export STEAMFORK_GRUB_ADDITIONAL_CMDLINEOPTIONS="amd_pstate=active initcall_blacklist=acpi_cpufreq_init amd_pstate.shared_mem=1 amdgpu.dpm=1 amdgpu.gpu_recovery=1 iomem=relaxed spi_amd.speed_dev=1 pcie_aspm=force module_blacklist=tpm log_buf_len=4M audit=0"
