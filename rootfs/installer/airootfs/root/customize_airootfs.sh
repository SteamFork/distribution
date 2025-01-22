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

# Clean up the installer to free space.
rm -rf /{usr/,}include
rm -rf /{usr/,}lib/cmake
rm -rf /{usr/,}lib/pkgconfig
rm -rf /{usr/,}man
rm -rf /{usr/,}share/aclocal
rm -rf /{usr/,}share/bash-completion
rm -rf /{usr/,}share/doc
rm -rf /{usr/,}share/gtk-doc
rm -rf /{usr/,}share/info
rm -rf /{usr/,}share/locale
rm -rf /{usr/,}share/man
rm -rf /{usr/,}share/pkgconfig
rm -rf /{usr/,}share/zsh

find / \( -name "*.orig" \
          -o -name "*.rej" \
          -o -name "*.a" \
          -o -name "*.la" \
          -o -name "*.o" \
          -o -name "*.in" \
          -o -name ".git*" \) \
          -exec rm -f {} \; 2>/dev/null || :

