export SHELL						:= /usr/bin/bash
export BUILD_DIR				:= $(shell pwd)
export INSTALLER_DIR		:= ${BUILD_DIR}/rootfs/installer
export OS_DIR						:= ${BUILD_DIR}/rootfs/steamfork
export SCRIPT_DIR				:= ${BUILD_DIR}/scripts
export WORK_DIR					:= ${BUILD_DIR}/_work
export IMAGE_DIR				:= ${BUILD_DIR}/release/images
export REPO_DIR					:= ${BUILD_DIR}/release/repos
export BUILD_VER				:= $(shell date +%Y%m%d.%H%M)
export RELEASE_TAG			:= $(shell date +%Y%m%d)
export UPSTREAM_REPO		:= upstream
export STEAMOS_VERSION	:= 3.6

RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(RUN_ARGS):;@:)

env:
	@echo "export SHELL=${SHELL}"
	@echo "export BUILD_DIR=${BUILD_DIR}"
	@echo "export INSTALLER_DIR=${INSTALLER_DIR}"
	@echo "export OS_DIR=${OS_DIR}"
	@echo "export SCRIPT_DIR=${SCRIPT_DIR}"
	@echo "export WORK_DIR=${WORK_DIR}"
	@echo "export IMAGE_DIR=${IMAGE_DIR}"
	@echo "export REPO_DIR=${REPO_DIR}"
	@echo "export BUILD_VER=${BUILD_VER}"
	@echo "export RELEASE_TAG=${RELEASE_TAG}"
	@echo "export UPSTREAM_REPO=${UPSTREAM_REPO}"
	@echo "export STEAMOS_VERSION=${STEAMOS_VERSION}"

world: packages-local packages-aur packages-sync images images-sync

upload: packages-sync images-sync

clean: image-clean build-clean

dist-clean: repo-clean image-clean build-clean

repo-clean:
	sudo rm -rf ${REPO_DIR}

repo-check:
	${SCRIPT_DIR}/sync check

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
	${SCRIPT_DIR}/build_package --repo local steamfork-keyring
	${SCRIPT_DIR}/build_package --repo local linux-firmware
	${SCRIPT_DIR}/build_package --repo local linux
	${SCRIPT_DIR}/build_package --repo aur   python-strictyaml
	${SCRIPT_DIR}/build_package --repo local python-sphinx-hawkmoth
	${SCRIPT_DIR}/build_package --repo local libdrm
	${SCRIPT_DIR}/build_package --repo local lib32-libdrm
	${SCRIPT_DIR}/build_package --repo local libglvnd
	${SCRIPT_DIR}/build_package --repo local lib32-libglvnd
	${SCRIPT_DIR}/build_package --repo local wayland
	${SCRIPT_DIR}/build_package --repo local lib32-wayland
	${SCRIPT_DIR}/build_package --repo local wayland-protocols
	${SCRIPT_DIR}/build_package --repo local xorg-xwayland
	${SCRIPT_DIR}/build_package --repo local mesa
	${SCRIPT_DIR}/build_package --repo local mesa-radv
	${SCRIPT_DIR}/build_package --repo local lib32-mesa
	${SCRIPT_DIR}/build_package --repo local lib32-mesa-radv
	${SCRIPT_DIR}/build_package --repo local gamescope
	${SCRIPT_DIR}/build_package --repo local gamescope-legacy
	${SCRIPT_DIR}/build_package --repo local ectool
	${SCRIPT_DIR}/build_package --repo local steam-powerbuttond
	${SCRIPT_DIR}/build_package --repo local steamfork-customizations
	${SCRIPT_DIR}/build_package --repo local steamfork-device-support
	${SCRIPT_DIR}/build_package --repo local steamfork-installer
	${SCRIPT_DIR}/build_package --repo local webrtc-audio-processing
	${SCRIPT_DIR}/build_package --repo local inputplumber
	${SCRIPT_DIR}/build_package --repo local steam-powerbuttond
	${SCRIPT_DIR}/build_package --repo local ryzenadj
	${SCRIPT_DIR}/build_package --repo local pikaur
	${SCRIPT_DIR}/build_package --repo local grafana-alloy

packages-aur:
	${SCRIPT_DIR}/build_package --repo aur wlr-randr
	### Waydroid
	${SCRIPT_DIR}/build_package --repo aur dnsmasq-git
	${SCRIPT_DIR}/build_package --repo aur libglibutil
	${SCRIPT_DIR}/build_package --repo aur libgbinder
	${SCRIPT_DIR}/build_package --repo local python-gbinder
	${SCRIPT_DIR}/build_package --repo local waydroid
	### Xbox Xone driver
	${SCRIPT_DIR}/build_package --repo aur xone-dongle-firmware
	${SCRIPT_DIR}/build_package --repo aur xone-dkms

package:
	${SCRIPT_DIR}/build_package $(RUN_ARGS)

package-aur:
	${SCRIPT_DIR}/build_package --repo aur $(RUN_ARGS)

packages-sync:
	${SCRIPT_DIR}/sync repo

mirrors-sync:
	${SCRIPT_DIR}/sync mirrors

.PHONY: release

release: 
	git merge ${UPSTREAM_REPO}/main
	${SCRIPT_DIR}/sync check
	git tag ${RELEASE_TAG}
	git push ${UPSTREAM_REPO} ${RELEASE_TAG}
