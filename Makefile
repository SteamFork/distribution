export SHELL		:= /usr/bin/bash
export BUILD_DIR	:= $(shell pwd)
export INSTALLER_DIR	:= ${BUILD_DIR}/rootfs/installer
export OS_DIR		:= ${BUILD_DIR}/rootfs/steamfork
export SCRIPT_DIR	:= ${BUILD_DIR}/scripts
export WORK_DIR		:= ${BUILD_DIR}/_work
export IMAGE_DIR	:= ${BUILD_DIR}/release/images
export REPO_DIR		:= ${BUILD_DIR}/release/repos
export BUILD_VER	:= $(shell date +%Y%m%d.%H%M.%S)

world: packages-local packages-aur packages-sync images-minimal images-rel images-sync

upload: packages-sync images-sync

clean:
	rm -rf ${WORK_DIR} ${IMAGE_DIR} ${REPO_DIR}

images-all: images-minimal images-rel

images-minimal:
	${SCRIPT_DIR}/mkimage minimal $@

images-rel:
	${SCRIPT_DIR}/mkimage rel $@

images-sync:
	${SCRIPT_DIR}/sync os

packages-all: packages-local packages-aur

packages-local:
	${SCRIPT_DIR}/mkpackage --repo local steamfork-keyring
	${SCRIPT_DIR}/mkpackage --repo local linux-firmware
	${SCRIPT_DIR}/mkpackage --repo local linux
	${SCRIPT_DIR}/mkpackage --repo local ectool
	${SCRIPT_DIR}/mkpackage --repo local steamfork-customizations-jupiter
	${SCRIPT_DIR}/mkpackage --repo local steamfork-device-support
	${SCRIPT_DIR}/mkpackage --repo local webrtc-audio-processing
	${SCRIPT_DIR}/mkpackage --repo local inputplumber
	${SCRIPT_DIR}/mkpackage --repo local steam-powerbuttond
	${SCRIPT_DIR}/mkpackage --repo local pikaur

packages-aur:
	${SCRIPT_DIR}/mkpackage --repo aur ryzenadj
	${SCRIPT_DIR}/mkpackage --repo aur binder_linux-dkms
	${SCRIPT_DIR}/mkpackage --repo aur wlr-randr

packages-sync:
	${SCRIPT_DIR}/sync repo
