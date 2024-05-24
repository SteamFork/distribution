#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2024 SteamFork (https://github.com/SteamFork)

# If we don't define a release type, assume it's a stable release.
if [ -n "${1}" ]
then
  RELEASETYPE="${1}"
else
  RELEASETYPE="rel"
fi

SCRIPT="$(realpath "${0}")"
SCRIPTPATH="$(dirname "${SCRIPT}")/installer-root"
BUILDDIR="$(pwd)/images/${RELEASETYPE}/steamfork-images"
WORKDIR="$(pwd)/images/${RELEASETYPE}/steamfork-workdir"
BUILDVER="${2:-$(date +%Y%m%d)}"

export BUILDDIR WORKDIR BUILDVER

# Builds are executed via automation using a minimal SteamFork installation.
if [ -f "/usr/bin/steamos-readonly" ]
then
  sudo steamos-readonly disable
fi

function cleanup() {
  sudo umount ${WORKDIR}/buildwork/rootfs_mnt  2>/dev/null ||:
  sudo rm -rf	${BUILDDIR} \
		${SCRIPTPATH}/airootfs/etc/steamforkinstall \
		${SCRIPTPATH}/buildinfo \
		/tmp/buildinfo \
		${SCRIPTPATH}/airootfs/root/install-scripts \
		${SCRIPTPATH}/packages.x86_64 \
		${WORKDIR}/image-build
}

# Clean up from any previous builds.
cleanup

# Push the installation scripts into the installer image.
cp -rf install-scripts ${SCRIPTPATH}/airootfs/root/

# If we have an alternate package set, use it.
if [ -e "${SCRIPTPATH}/package_lists/${RELEASETYPE}.x86_64" ]
then
  PACKAGESET="${RELEASETYPE}"
else
  PACKAGESET="full"
fi
cp -f ${SCRIPTPATH}/package_lists/${PACKAGESET}.x86_64 ${SCRIPTPATH}/packages.x86_64

# Build the SteamFork image
sudo os-root/build.sh --flavor ${RELEASETYPE} --deployment_rel ${RELEASETYPE} --snapshot_ver "${BUILDVER}" --workdir "${WORKDIR}" --output-dir "${BUILDDIR}" --add-release

# Prep for the installation image
source ${BUILDDIR}/latest_${RELEASETYPE}.releasemeta
sudo cp ${BUILDDIR}/latest_${RELEASETYPE}.releasemeta ${BUILDDIR}/buildinfo
sudo ln -sf ${BUILDDIR}/latest_${RELEASETYPE}.releasemeta /tmp/buildinfo
echo ${IMAGEFILE} | sudo tee ${BUILDDIR}/currentcandidate
${SCRIPTPATH}/getlatestbuild.sh || exit 1

# Build the installation image
sudo mkarchiso -v -w ${WORKDIR}/image-build -o ${BUILDDIR}/steamfork-installer ${SCRIPTPATH}
