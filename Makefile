RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
$(eval $(RUN_ARGS):;@:)

export SHELL		:= /usr/bin/bash
export BUILD_DIR	:= $(shell pwd)
export STEAMOS_VERSION  := 3.7
export BUILD_VER        := $(shell date +%Y%m%d.%H%M)
export RELEASE_TAG      := $(shell date +%Y%m%d)
export OS_ARCH		:= $(shell uname -m)
export INSTALLER_DIR    := ${BUILD_DIR}/rootfs/installer
export OS_DIR           := ${BUILD_DIR}/rootfs/steamfork
export SCRIPT_DIR       := ${BUILD_DIR}/scripts
export WORK_DIR         := ${BUILD_DIR}/_work
export IMAGE_DIR        := ${BUILD_DIR}/release/images/${STEAMOS_VERSION}
export REPO_DIR         := ${BUILD_DIR}/release/repos
export UPSTREAM_REPO	:= upstream

PACKAGES_LIST := $(shell cat metadata/packages.list)

env:
	@echo "RUN_ARGS=$(RUN_ARGS)"
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
	@echo "export OS_ARCH=${OS_ARCH}"
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
	${SCRIPT_DIR}/mkimage stable $(RUN_ARGS)

images-sync:
	${SCRIPT_DIR}/sync os-sync

images-release:
	${SCRIPT_DIR}/sync os-release

packages-all:
	${SCRIPT_DIR}/build_all_packages

package:
	${SCRIPT_DIR}/build_package --repo local $(RUN_ARGS)

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
