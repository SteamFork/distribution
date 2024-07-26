#!/bin/bash

plymouth-set-default-theme -R steamos

chmod +x -R /usr/bin /etc/lib /etc/X11 /home/liveuser/Desktop
systemctl enable sddm

# Delete conflicting files
for CONFLICT in /etc/X11/Xsession.d/50rotate-screen \
                /etc/sddm.conf.d/steamdeck.conf \
                /etc/sddm.conf.d/steamos.conf \
                /home/liveuser/Desktop/Return.desktop \
                "/home/liveuser/Desktop/SteamFork Project.desktop" \
		"/home/liveuser/Desktop/Setup Streaming.desktop" \
		"/home/liveuser/Desktop/Setup Helpers.desktop" \
                /usr/lib/systemd/system/home-swapfile.swap \
		/usr/lib/systemd/system/swapfile.service
do
  if [ -e "${CONFLICT}" ]
  then
    rm -f "${CONFLICT}"
  fi
done
