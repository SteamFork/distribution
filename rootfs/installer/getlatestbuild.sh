#!/bin/bash
SCRIPT=$(realpath "$0")
DOWNLOADPATH=${INSTALLER_DIR}/airootfs/etc/install.image
preferred_imgtype=".img.zst"

source ${IMAGE_DIR}/buildinfo

mkdir -p ${DOWNLOADPATH}
cp ${IMAGE_DIR}/${IMAGEFILE}${preferred_imgtype} ${DOWNLOADPATH}

