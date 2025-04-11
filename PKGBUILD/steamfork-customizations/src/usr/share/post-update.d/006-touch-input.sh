#!/bin/bash

for USER in $(awk 'BEGIN {FS=":"} {print $1}' /etc/passwd)
do
	FILE_PATH="/home/${USER}/.config/kwinrc"
	WAYLAND_SECTION="[Wayland]"
	INPUT_METHOD="InputMethod[\$e]=/usr/share/applications/com.github.maliit.keyboard.desktop"

	if [ ! -f "$FILE_PATH" ]; then
	    # Create the file with the initial content
	    cat <<EOF > "$FILE_PATH"
$WAYLAND_SECTION
$INPUT_METHOD
EOF
	else
	    if grep -q "^\[Wayland\]" "$FILE_PATH"; then
	        if grep -q "^InputMethod\[\$e\]=" "$FILE_PATH"; then
	            sed -i "s|^InputMethod\[\$e\]=.*|$INPUT_METHOD|" "$FILE_PATH"
	        else
	            sed -i "/^\[Wayland\]/a $INPUT_METHOD" "$FILE_PATH"
	        fi
	    else
	        echo -e "\n$WAYLAND_SECTION\n$INPUT_METHOD" >> "$FILE_PATH"
	    fi
	fi

	chown ${USER}:${USER} ${FILE_PATH}
	chmod 0600 ${FILE_PATH}
done
