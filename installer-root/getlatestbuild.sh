#!/bin/bash
SCRIPT=$(realpath "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
DOWNLOADPATH=${SCRIPTPATH}/airootfs/etc/steamforkinstall
preferred_imgtype=".img.zst"

source ${BUILDDIR}/buildinfo

mkdir -p ${DOWNLOADPATH}
cp ${BUILDDIR}/${IMAGEFILE}${preferred_imgtype} ${DOWNLOADPATH}

