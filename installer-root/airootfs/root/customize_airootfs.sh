#!/bin/bash

cd /root
cp -R install-scripts/* /
cd -

plymouth-set-default-theme -R steamos

chmod +x -R /usr/bin /etc/lib /etc/X11 /home/liveuser/Desktop
systemctl enable sddm

# Delete conflicting files
for CONFLICT in /etc/X11/Xsession.d/50rotate-screen \
                /etc/sddm.conf.d/steamdeck.conf \
                /etc/sddm.conf.d/steamos.conf \
                /home/liveuser/Desktop/Return.desktop \
                "/home/liveuser/Desktop/SteamFork Project.desktop" \
                /usr/lib/systemd/system/multi-user.target.wants/steamfork-enable-swap.service
do
  if [ -e "${CONFLICT}" ]
  then
    rm -f "${CONFLICT}"
  fi
done
