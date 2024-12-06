export SHELL		:= /usr/bin/bash
export BUILD_DIR	:= $(shell pwd)
export INSTALLER_DIR	:= ${BUILD_DIR}/rootfs/installer
export OS_DIR		:= ${BUILD_DIR}/rootfs/steamfork
export SCRIPT_DIR	:= ${BUILD_DIR}/scripts
export WORK_DIR		:= ${BUILD_DIR}/_work
export IMAGE_DIR	:= ${BUILD_DIR}/release/images
export REPO_DIR		:= ${BUILD_DIR}/release/repos
export BUILD_VER	:= $(shell date +%Y%m%d.%H%M)
export STEAMOS_VERSION	:= 3.6

RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(RUN_ARGS):;@:)

world: packages-local packages-aur packages-sync images images-sync

upload: packages-sync images-sync

clean: image-clean build-clean

dist-clean: repo-clean image-clean build-clean

repo-clean:
	sudo rm -rf ${REPO_DIR}

image-clean:
	sudo umount -qR ${WORK_DIR}/image/buildwork/rootfs_mnt ||:
	sudo rm -rf ${WORK_DIR} ${IMAGE_DIR}

build-clean:
	sudo rm -f /var/lib/pacman/db.lck
	yes | sudo pacman -Scc

images-all: images

image: image-clean
	${SCRIPT_DIR}/mkimage $(RUN_ARGS)

images:
	${SCRIPT_DIR}/mkimage minimal $(RUN_ARGS)
	${SCRIPT_DIR}/mkimage rel $(RUN_ARGS)

images-sync:
	${SCRIPT_DIR}/sync os-sync

images-release:
	${SCRIPT_DIR}/sync os-release

packages-all: packages-local packages-aur

packages-local:
	${SCRIPT_DIR}/mkpackage --repo local steamfork-keyring
	${SCRIPT_DIR}/mkpackage --repo local linux-firmware
	${SCRIPT_DIR}/mkpackage --repo local linux
	${SCRIPT_DIR}/mkpackage --repo aur   python-strictyaml
	${SCRIPT_DIR}/mkpackage --repo local python-sphinx-hawkmoth
	${SCRIPT_DIR}/mkpackage --repo local libdrm
	${SCRIPT_DIR}/mkpackage --repo local libglvnd
	${SCRIPT_DIR}/mkpackage --repo local mesa
	${SCRIPT_DIR}/mkpackage --repo local mesa-radv
	${SCRIPT_DIR}/mkpackage --repo local lib32-libdrm
	${SCRIPT_DIR}/mkpackage --repo local lib32-libglvnd
	${SCRIPT_DIR}/mkpackage --repo local lib32-mesa
	${SCRIPT_DIR}/mkpackage --repo local lib32-mesa-radv
	${SCRIPT_DIR}/mkpackage --repo local gamescope
	${SCRIPT_DIR}/mkpackage --repo local gamescope-legacy
	${SCRIPT_DIR}/mkpackage --repo local ectool
	${SCRIPT_DIR}/mkpackage --repo local steam-powerbuttond
	${SCRIPT_DIR}/mkpackage --repo local steamfork-customizations
	${SCRIPT_DIR}/mkpackage --repo local steamfork-device-support
	${SCRIPT_DIR}/mkpackage --repo local steamfork-installer
	${SCRIPT_DIR}/mkpackage --repo local webrtc-audio-processing
	${SCRIPT_DIR}/mkpackage --repo local inputplumber
	${SCRIPT_DIR}/mkpackage --repo local steam-powerbuttond
	${SCRIPT_DIR}/mkpackage --repo local ryzenadj
	${SCRIPT_DIR}/mkpackage --repo local pikaur
	${SCRIPT_DIR}/mkpackage --repo local grafana-alloy

packages-aur:
	${SCRIPT_DIR}/mkpackage --repo aur wlr-randr
	### Waydroid
	${SCRIPT_DIR}/mkpackage --repo aur dnsmasq-git
	${SCRIPT_DIR}/mkpackage --repo aur libglibutil
	${SCRIPT_DIR}/mkpackage --repo aur libgbinder
	${SCRIPT_DIR}/mkpackage --repo aur python-gbinder
	${SCRIPT_DIR}/mkpackage --repo local waydroid
	### Xbox Xone driver
	${SCRIPT_DIR}/mkpackage --repo aur xone-dongle-firmware
	${SCRIPT_DIR}/mkpackage --repo aur xone-dkms

package:
	${SCRIPT_DIR}/mkpackage $(RUN_ARGS)

package-aur:
	${SCRIPT_DIR}/mkpackage --repo aur $(RUN_ARGS)

packages-sync:
	${SCRIPT_DIR}/sync repo

mirrors-sync:
	${SCRIPT_DIR}/sync mirrors
