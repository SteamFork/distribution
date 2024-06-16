#!/bin/bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2024 SteamFork (https://github.com/SteamFork)

set -e
set -x

while [[ $# -ge 2 ]]
do
  KEY="$1"
  case ${KEY} in
      --branch)
      RELEASETYPE="$2"
      shift # past argument
      shift # past value
      ;;
      --repo)
      PKGSOURCE="$2"
      shift # past argument
      shift # past value
      ;;
      --*)
        echo "Unknown option ${KEY}"
	exit 1
      ;;
  esac
done

if [ -z "${RELEASETYPE}" ]
then
  RELEASETYPE="rel"
fi

if [ -z "${PKGSOURCE}" ]
then
  PKGSOURCE="local"
fi

BUILDUSER=${USER}
WORKDIR="$(pwd)/packages/build-${1}"
REPODIR="$(pwd)/packages/steamfork/${RELEASETYPE}"

sudo steamos-readonly disable
sudo rm -rf /var/lib/pacman/db.lck ${WORKDIR}

sudo mkdir -p ${WORKDIR} ${REPODIR} 2>/dev/null
sudo chown ${BUILDUSER}:${BUILDUSER} ${WORKDIR} ${REPODIR}

for STALE_PACKAGE in ${REPODIR}/${1}-[0-9]*
do
  rm -f "${STALE_PACKAGE}"
done

case ${PKGSOURCE} in
  aur)
    git clone --depth=1 https://aur.archlinux.org/${1}.git ${WORKDIR}
  ;;
  sf)
    git clone --depth=1 git@github.com:steamfork/${1}.git ${WORKDIR}
  ;;
  local)
    if [ -d "$(pwd)/PKGBUILD/${1}" ]
    then
      cp -r "$(pwd)/PKGBUILD/${1}/"* ${WORKDIR}
    else
      echo "No local package, don't know what to do."
      exit 1
    fi
  ;;
  *)
    echo "build-package.sh type repo"
    exit 1
  ;;
esac

PIKAUR_CMD="PKGDEST=${REPODIR} pikaur --noconfirm --rebuild --build-gpgdir /etc/pacman.d/gnupg -S -P ${WORKDIR}/PKGBUILD"
PIKAUR_RUN=(bash -c "${PIKAUR_CMD}")
"${PIKAUR_RUN[@]}"
# if aur package is not successfully built, exit
if [ $? -ne 0 ]; then
    echo "Build failed. Stopping..."
    exit -1
fi
# remove any epoch (:) in name, replace with -- since not allowed in artifacts
find ${REPODIR}/*.pkg.tar* -type f -name '*:*' -execdir bash -c 'mv "$1" "${1//:/--}"' bash {} \;
