if [[ ! $EDITOR ]] && command -v vim >/dev/null
then
	EDITOR=vim
	export EDITOR
fi

if [[ ! $VISUAL ]] && command -v gvim >/dev/null
then
	VISUAL=gvim
	export VISUAL
fi

# Don't copy xattr(s), since it will fail due to our FS setup.
# The rootfs being brtfs and the /etc overlay ext4.
# https://gitlab.steamos.cloud/holo/holo/-/merge_requests/107#note_46441
export DRACUT_NO_XATTR=1
