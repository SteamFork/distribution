#!/bin/bash
rm -rf /tmp/builder-releasetag
rm -rf /tmp/build_temp_ver

export DISTRO_NAME="SteamFork"
export IMAGE_HOSTNAME="steamfork"
export OS_CODENAME="Testing"
export OS_FS_PREFIX="sf"

export HOME_URL="https://www.steamfork.org"
export DOCUMENTATION_URL="https://wiki.steamfork.org"
export SUPPORT_URL="${HOME_URL}"
export BUG_REPORT_URL="https://github.com/SteamFork#community"
echo -e ${RELEASE_TAG} > /tmp/builder-releasetag
echo -e "$(echo ${DISTRO_NAME} | tr '[:upper:]' '[:lower:]')_$(echo ${OS_CODENAME} | tr '[:upper:]' '[:lower:]')_${RELEASE_TAG}" > /tmp/build_temp_ver
export BUILDVER=$(cat /tmp/build_temp_ver)
export IMAGEFILE="${BUILDVER}"
export ENABLED_SERVICES=( sddm
			accounts-daemon
                        bluetooth
                        systemd-timesyncd
                        systemd-resolved
                        NetworkManager
                        firewalld
                        inputplumber
                        steam-powerbuttond
                        steamos-offload.target
                        fstrim.timer
                        var-lib-pacman.mount
                        etc.mount
                        nix.mount
                        opt.mount
                        root.mount
                        srv.mount
                        usr-lib-debug.mount
                        usr-local.mount
                        var-cache-pacman.mount
                        var-lib-docker.mount
                        var-lib-flatpak.mount
                        var-lib-systemd-coredump.mount
                        var-log.mount
                        var-tmp.mount )
export DISABLED_SERVICES=(jupiter-controller-update.service
			  jupiter-fan-control.service
			  wpa_supplicant.service
		  	  iwd.service)
export PLYMOUTH_THEME="steamfork"
export FINAL_DISTRIB_IMAGE=${BUILDVER}
export KERNELCHOICE="linux"
export BASE_BOOTSTRAP_PKGS="base base-devel linux-firmware amd-ucode intel-ucode sddm dkms jq btrfs-progs core-${STEAMOS_VERSION}/grub efibootmgr openssh plymouth"
export STEAMOS_PKGS="7zip
                    a52dec
                    aardvark-dns
                    abseil-cpp
                    accounts-qml-module
                    accountsservice
                    acl
                    adobe-source-code-pro-fonts
                    adwaita-cursors
                    adwaita-icon-theme
                    adwaita-icon-theme-legacy
                    aha
                    alsa-card-profiles
                    alsa-lib
                    alsa-plugins
                    alsa-topology-conf
                    alsa-ucm-conf
                    alsa-utils
                    amd-ucode
                    anthy
                    aom
                    appstream
                    appstream-qt
                    arch-install-scripts
                    archlinux-appstream-data
                    archlinux-keyring
                    argon2
                    aribb24
                    ark
                    aspell
                    aspell-en
                    assimp
                    at-spi2-core
                    atomupd-daemon
                    attica
                    attr
                    audit
                    avahi
                    baloo
                    baloo-widgets
                    base
                    bash
                    bash-completion
                    bats
                    binutils
                    blas
                    bluedevil
                    bluez
                    bluez-libs
                    bluez-qt
                    bluez-utils
                    bolt
                    boost-libs
                    breakpad
                    breeze
                    breeze-grub
                    breeze-gtk
                    breeze-icons
                    brotli
                    btop
                    btrfs-progs
                    bubblewrap
                    bzip2
                    ca-certificates
                    ca-certificates-mozilla
                    ca-certificates-utils
                    cairo
                    cairomm-1.16
                    cantarell-fonts
                    caps
                    casync
                    catatonit
                    cblas
                    cdparanoia
                    cfitsio
                    cifs-utils
                    clinfo
                    composefs
                    conmon
                    containers-common
                    convertlit
                    coreutils
                    cpupower
                    criu
                    crun
                    cryptsetup
                    cups
                    cups-filters
                    cups-pdf
                    curl
                    dav1d
                    db5.3
                    dbus
                    dbus-broker
                    dbus-broker-units
                    dbus-units
                    dconf
                    ddcutil
                    default-cursors
                    desktop-file-utils
                    desync
                    device-mapper
                    diffutils
                    ding-libs
                    discount
                    discover
                    distrobox
                    djvulibre
                    dmidecode
                    dolphin
                    dos2unix
                    dosfstools
                    double-conversion
                    drkonqi
                    drm_info
                    drm_janitor
                    duktape
                    e2fsprogs
                    earlyoom
                    ebook-tools
                    editorconfig-core-c
                    efibootmgr
                    efivar
                    elfutils
                    ell
                    enchant
                    evtest
                    exfat-utils
                    exiv2
                    expat
                    f3
                    faad2
                    fatresize
                    fd
                    ffmpeg
                    ffmpeg4.4
                    ffmpegthumbs
                    fftw
                    file
                    filelight
                    filesystem
                    findutils
                    firewalld
                    fish
                    flac
                    flatpak
                    flatpak-kcm
                    fontconfig
                    frameworkintegration
                    freeglut
                    freerdp
                    freerdp2
                    freetype2
                    fribidi
                    fuse-common
                    fuse-overlayfs
                    fuse2
                    fuse3
                    fwupd-efi
                    fwupd-minimal
                    galileo-mura
                    gamemode
                    steamfork/gamescope
                    steamfork/gamescope-legacy
                    gawk
                    gc
                    gcc-libs
                    gdb
                    gdb-common
                    gdbm
                    gdk-pixbuf2
                    gettext
                    ghostscript
                    giflib
                    git
                    glew
                    glfw
                    glib-networking
                    glib2
                    glibc
                    glibmm-2.68
                    glslang
                    glu
                    gmp
                    gnulib-l10n
                    gnupg
                    gnutls
                    gobject-introspection-runtime
                    gocryptfs
                    gperftools
                    gpgme
                    gpm
                    gptfdisk
                    gpu-trace
                    graphene
                    graphite
                    grep
                    core-${STEAMOS_VERSION}/grub
                    gsettings-desktop-schemas
                    gsettings-system-schemas
                    gsm
                    gssdp
                    gssproxy
                    gst-plugin-pipewire
                    gst-plugins-bad-libs
                    gst-plugins-base
                    gst-plugins-base-libs
                    gstreamer
                    gtest
                    gtk-update-icon-cache
                    gtk3
                    gtk4
                    gtkmm-4.0
                    guile
                    gupnp
                    gupnp-igd
                    gwenview
                    gzip
                    harfbuzz
                    hicolor-icon-theme
                    hidapi
                    highway
                    holo-desync
                    holo-dmi-rules
                    holo-earlyoom
                    holo-fstab-repair
                    holo-glibc-locales
                    holo-keyring
                    holo-nfs-utils-tmpfiles
                    holo-nix-offload
                    holo-sudo
                    holo-zram-swap
                    htop
                    hunspell
                    hwdata
                    hwloc
                    i2c-tools
                    iana-etc
                    ibus
                    ibus-anthy
                    ibus-hangul
                    ibus-pinyin
                    ibus-table
                    ibus-table-cangjie-lite
                    icu
                    ijs
                    imath
                    inputplumber
                    intel-ucode
                    iotop
                    iproute2
                    iptables
                    iputils
                    iso-codes
                    iw
                    iwd
                    jansson
                    jasper
                    jbig2dec
                    jbigkit
                    jq
                    json-c
                    json-glib
                    jsoncpp
                    jupiter-dock-updater-bin
                    jupiter-fan-control
                    jupiter-firewall
                    jupiter-hw-support
                    jupiter-legacy-support
                    jupiter-resolved-nomdns
                    jupiter-steamos-log-submitter
                    kaccounts-integration
                    kactivitymanagerd
                    karchive
                    kate
                    kauth
                    kbd
                    kbookmarks
                    kcmutils
                    kcodecs
                    kcolorpicker
                    kcolorscheme
                    kcompletion
                    kconfig
                    kconfigwidgets
                    kcontacts
                    kcoreaddons
                    kcrash
                    kdbusaddons
                    kde-cli-tools
                    kde-gtk-config
                    kdeclarative
                    kdeconnect
                    kdecoration
                    kded
                    kdeplasma-addons
                    kdesu
                    kdialog
                    kdnssd
                    kdsoap-qt6
                    kdsoap-ws-discovery-client
                    kdumpst
                    kexec-tools
                    keyutils
                    kfilemetadata
                    kgamma
                    kglobalaccel
                    kglobalacceld
                    kguiaddons
                    kholidays
                    ki18n
                    kiconthemes
                    kidletime
                    kimageannotator
                    kinfocenter
                    kio
                    kio-extras
                    kio-fuse
                    kirigami
                    kirigami-addons
                    kitemmodels
                    kitemviews
                    kitty-terminfo
                    kjobwidgets
                    kmenuedit
                    kmod
                    knewstuff
                    knotifications
                    knotifyconfig
                    konsole
                    kpackage
                    kparts
                    kpeople
                    kpipewire
                    kpmcore
                    kpty
                    kquickcharts
                    krb5
                    krdp
                    krunner
                    kscreen
                    kscreenlocker
                    kservice
                    ksshaskpass
                    kstatusnotifieritem
                    ksvg
                    ksystemstats
                    ktexteditor
                    ktextwidgets
                    kunitconversion
                    kuserfeedback
                    kwallet
                    kwallet-pam
                    kwayland
                    kwidgetsaddons
                    kwin
                    kwindowsystem
                    kwrited
                    kxmlgui
                    l-smash
                    lame
                    lapack
                    layer-shell-qt
                    lcms2
                    ldb
                    less
                    lib32-alsa-lib
                    lib32-alsa-plugins
                    lib32-brotli
                    lib32-bzip2
                    lib32-curl
                    lib32-dbus
                    lib32-e2fsprogs
                    lib32-expat
                    lib32-flac
                    lib32-fontconfig
                    lib32-freetype2
                    lib32-gamemode
                    lib32-gamescope
                    lib32-gcc-libs
                    lib32-glib2
                    lib32-glibc
                    lib32-harfbuzz
                    lib32-icu
                    lib32-json-c
                    lib32-keyutils
                    lib32-krb5
                    lib32-libasyncns
                    lib32-libcap
                    lib32-libdrm
                    lib32-libelf
                    lib32-libffi
                    lib32-libgcrypt
                    lib32-libglvnd
                    lib32-libgpg-error
                    lib32-libidn2
                    lib32-libldap
                    lib32-libnghttp2
                    lib32-libnghttp3
                    lib32-libnm
                    lib32-libnsl
                    lib32-libogg
                    lib32-libpciaccess
                    lib32-libpipewire
                    lib32-libpng
                    lib32-libpsl
                    lib32-libpulse
                    lib32-libsndfile
                    lib32-libssh2
                    lib32-libtasn1
                    lib32-libtirpc
                    lib32-libunistring
                    lib32-libunwind
                    lib32-libva
                    steamfork/lib32-libva-mesa-driver
                    lib32-libvdpau
                    lib32-libvorbis
                    lib32-libx11
                    lib32-libxau
                    lib32-libxcb
                    lib32-libxcrypt
                    lib32-libxcrypt-compat
                    lib32-libxdamage
                    lib32-libxdmcp
                    lib32-libxext
                    lib32-libxfixes
                    lib32-libxinerama
                    lib32-libxml2
                    lib32-libxshmfence
                    lib32-libxss
                    lib32-libxxf86vm
                    lib32-llvm-libs
                    lib32-lm_sensors
                    lib32-mangohud
                    steamfork/lib32-mesa
                    steamfork/lib32-mesa-vdpau
                    lib32-ncurses
                    lib32-nspr
                    lib32-nss
                    lib32-openal
                    lib32-openssl
                    lib32-opus
                    lib32-p11-kit
                    lib32-pam
                    lib32-pcre2
                    lib32-pipewire
                    lib32-renderdoc-minimal
                    lib32-spirv-llvm-translator
                    lib32-spirv-tools
                    lib32-sqlite
                    lib32-systemd
                    lib32-util-linux
                    lib32-vulkan-icd-loader
                    steamfork/lib32-vulkan-radeon
                    steamfork/lib32-vulkan-virtio
                    lib32-wayland
                    lib32-xcb-util-keysyms
                    lib32-xz
                    lib32-zlib
                    lib32-zstd
                    libaccounts-glib
                    libaccounts-qt
                    libaio
                    libarchive
                    libass
                    libassuan
                    libasyncns
                    libatasmart
                    libavc1394
                    libavif
                    libb2
                    libblockdev
                    libblockdev-crypto
                    libblockdev-fs
                    libblockdev-loop
                    libblockdev-mdraid
                    libblockdev-nvme
                    libblockdev-part
                    libblockdev-swap
                    libbluray
                    libbpf
                    libbs2b
                    libbsd
                    libbytesize
                    libcanberra
                    libcap
                    libcap-ng
                    libcbor
                    libcec
                    libcloudproviders
                    libcolord
                    libcups
                    libcupsfilters
                    libdaemon
                    libdatrie
                    libdbusmenu-glib
                    libdbusmenu-gtk3
                    libdc1394
                    libdca
                    libdecor
                    libdeflate
                    libdisplay-info
                    libdmtx
                    libdovi
                    libdrm
                    libdvbpsi
                    libdvdnav
                    libdvdread
                    libebml
                    libedit
                    libei
                    libelf
                    libepoxy
                    libevdev
                    libevent
                    libexif
                    libfakekey
                    libfdk-aac
                    libffi
                    libfontenc
                    libfreeaptx
                    libgcrypt
                    libgirepository
                    libglvnd
                    libgpg-error
                    libgudev
                    libhangul
                    libibus
                    libice
                    libidn
                    libidn2
                    libiec61883
                    libiio
                    libimobiledevice
                    libimobiledevice-glue
                    libinih
                    libinput
                    libjcat
                    libjpeg-turbo
                    libjxl
                    libkdcraw
                    libkexiv2
                    libksba
                    libkscreen
                    libksysguard
                    liblc3
                    libldac
                    libldap
                    libmad
                    libmalcontent
                    libmatroska
                    libmbim
                    libmd
                    libmfx
                    libmm-glib
                    libmng
                    libmnl
                    libmodplug
                    libmpcdec
                    libmpeg2
                    libmtp
                    libmysofa
                    libndp
                    libnet
                    libnetfilter_conntrack
                    libnewt
                    libnfnetlink
                    libnftnl
                    libnghttp2
                    libnghttp3
                    libnice
                    libnl
                    libnm
                    libnotify
                    libnsl
                    libnvme
                    libogg
                    libopenmpt
                    libp11-kit
                    libpaper
                    libpcap
                    libpciaccess
                    libpfm
                    libpgm
                    libpipewire
                    libplacebo
                    libplasma
                    libplist
                    libpng
                    libppd
                    libproxy
                    libpsl
                    libpulse
                    libqaccessibilityclient-qt6
                    libqalculate
                    libqmi
                    libqrtr-glib
                    libraw
                    libraw1394
                    librsvg
                    libsamplerate
                    libsasl
                    libseccomp
                    libsecret
                    libserialport
                    libsigc++-3.0
                    libsm
                    libsndfile
                    libsodium
                    libsoup3
                    libsoxr
                    libspectre
                    libssh
                    libssh2
                    libstemmer
                    libsysprof-capture
                    libtar
                    libtasn1
                    libteam
                    libthai
                    libtheora
                    libtiff
                    libtirpc
                    libtommath
                    libtool
                    libtraceevent
                    libtracefs
                    libunibreak
                    libunistring
                    libunwind
                    libupnp
                    libusb
                    libusbmuxd
                    libutempter
                    libva
                    libva-intel-driver
                    steamfork/libva-mesa-driver
                    libvdpau
                    libverto
                    libvlc
                    libvorbis
                    libvpl
                    libvpx
                    libwacom
                    libwbclient
                    libwebp
                    libwireplumber
                    libx11
                    libxau
                    libxaw
                    libxcb
                    libxcomposite
                    libxcrypt
                    libxcrypt-compat
                    libxcursor
                    libxcvt
                    libxdamage
                    libxdmcp
                    libxext
                    libxfixes
                    libxfont2
                    libxft
                    libxi
                    libxinerama
                    libxkbcommon
                    libxkbcommon-x11
                    libxkbfile
                    libxml2
                    libxmlb
                    libxmu
                    libxpm
                    libxrandr
                    libxrender
                    libxres
                    libxshmfence
                    libxslt
                    libxss
                    libxt
                    libxtst
                    libxv
                    libxxf86vm
                    libyaml
                    libyuv
                    libzip
                    licenses
                    lilv
                    linux-api-headers
                    llvm-libs
                    lm_sensors
                    lmdb
                    lsb-release
                    lsof
                    lua
                    luajit
                    luit
                    lv2
                    lz4
                    lzo
                    makedumpfile
                    maliit-framework
                    maliit-keyboard
                    mandoc
                    mangohud
                    md4c
                    mdadm
                    media-player-info
                    steamfork/mesa
                    mesa-utils
                    steamfork/mesa-vdpau
                    milou
                    minizip
                    mkinitcpio
                    mkinitcpio-busybox
                    mobile-broadband-provider-info
                    modemmanager
                    modemmanager-qt
                    mpdecimal
                    mpfr
                    mpg123
                    mtdev
                    nano
                    ncdu
                    ncurses
                    netavark
                    nethogs
                    nettle
                    networkmanager
                    networkmanager-openvpn
                    networkmanager-qt
                    nfs-utils
                    nfsidmap
                    nftables
                    noise-suppression-for-voice
                    noto-fonts
                    noto-fonts-cjk
                    npth
                    nspr
                    nss
                    nss-mdns
                    ntfs-3g
                    numactl
                    nvme-cli
                    ocean-sound-theme
                    ocl-icd
                    okular
                    onetbb
                    oniguruma
                    openal
                    opencore-amr
                    opencv
                    openexr
                    openjpeg2
                    openssh
                    openssl
                    openvpn
                    openxr
                    opus
                    orc
                    ostree
                    oxygen
                    oxygen-sounds
                    p11-kit
                    p8-platform
                    pacman
                    pacman-mirrorlist
                    pam
                    pambase
                    pango
                    pangomm-2.48
                    parallel
                    parted
                    partitionmanager
                    paru
                    passt
                    pavucontrol
                    pciutils
                    pcre
                    pcre2
                    pcsclite
                    perf
                    perl
                    perl-error
                    perl-mailtools
                    perl-timedate
                    phonon-qt6
                    phonon-qt6-vlc
                    pinentry
                    pipewire
                    pipewire-alsa
                    pipewire-audio
                    pipewire-jack
                    pipewire-pulse
                    pipewire-v4l2
                    pipewire-x11-bell
                    pixman
                    pkcs11-helper
                    plasma-activities
                    plasma-activities-stats
                    plasma-browser-integration
                    plasma-desktop
                    plasma-disks
                    plasma-firewall
                    plasma-integration
                    plasma-meta
                    plasma-nm
                    plasma-pa
                    plasma-remotecontrollers
                    plasma-systemmonitor
                    plasma-thunderbolt
                    plasma-vault
                    plasma-wayland-protocols
                    plasma-welcome
                    plasma-workspace
                    plasma-workspace-wallpapers
                    plasma5support
                    podman
                    polkit
                    polkit-kde-agent
                    polkit-qt6
                    poppler
                    poppler-data
                    poppler-qt6
                    popt
                    portaudio
                    powerdevil
                    powertop
                    ppp
                    print-manager
                    prison
                    procps-ng
                    protobuf
                    protobuf-c
                    psmisc
                    pulseaudio-qt
                    purpose
                    python
                    python-aiohappyeyeballs
                    python-aiohttp
                    python-aiosignal
                    python-anyio
                    python-attrs
                    python-capng
                    python-certifi
                    python-click
                    python-crcmod
                    python-dbus
                    python-dbus-next
                    python-evdev
                    python-frozenlist
                    python-gobject
                    python-h11
                    python-hid
                    python-httpcore
                    python-httpx
                    python-idna
                    python-minidump
                    python-multidict
                    python-progressbar
                    python-protobuf
                    python-psutil
                    python-pyalsa
                    python-pyaml
                    python-pyelftools
                    python-pyenchant
                    python-pygdbmi
                    python-semantic-version
                    python-sentry_sdk
                    python-sniffio
                    python-typing_extensions
                    python-urllib3
                    python-utils
                    python-yaml
                    python-yarl
                    pyzy
                    qca-qt6
                    qcoro
                    qpdf
                    qqc2-breeze-style
                    qqc2-desktop-style
                    qrencode
                    qt5-base
                    qt5-declarative
                    qt5-feedback
                    qt5-graphicaleffects
                    qt5-multimedia
                    qt5-quickcontrols2
                    qt5-svg
                    qt5-tools
                    qt5-translations
                    qt5-wayland
                    qt5-x11extras
                    qt6-5compat
                    qt6-base
                    qt6-connectivity
                    qt6-declarative
                    qt6-imageformats
                    qt6-multimedia
                    qt6-multimedia-ffmpeg
                    qt6-positioning
                    qt6-quick3d
                    qt6-quicktimeline
                    qt6-sensors
                    qt6-shadertools
                    qt6-speech
                    qt6-svg
                    qt6-tools
                    qt6-translations
                    qt6-virtualkeyboard
                    qt6-wayland
                    qt6-webchannel
                    qt6-webengine
                    qt6-websockets
                    qt6-webview
                    qtkeychain-qt6
                    rauc
                    rav1e
                    re2
                    readline
                    renderdoc-minimal
                    ripgrep
                    ripgrep-all
                    rpcbind
                    rsync
                    rtkit
                    rubberband
                    rxvt-unicode-terminfo
                    sbc
                    sddm
                    sddm-kcm
                    sdl2
                    sdl2_ttf
                    seatd
                    sed
                    serd
                    shaderc
                    shadow
                    shared-mime-info
                    signon-kwallet-extension
                    signon-plugin-oauth2
                    signon-ui
                    signond
                    slang
                    smartmontools
                    smbclient
                    snappy
                    socat
                    solid
                    sonnet
                    sord
                    sound-theme-freedesktop
                    source-highlight
                    spectacle
                    speex
                    speexdsp
                    spirv-llvm-translator
                    spirv-tools
                    sqlite
                    squashfs-tools
                    sratom
                    srt
                    sshfs
                    steam-im-modules
                    steam-jupiter-stable
                    steam_notif_daemon
                    steamdeck-dsp
                    steamfork/steamdeck-kde-presets
                    steamos-atomupd-client
                    steamos-customizations-jupiter
                    steamos-devkit-service
                    steamos-efi
                    steamos-kdumpst-layer
                    steamos-log-submitter
                    steamos-manager
                    steamos-networking-tools
                    steamos-powerbuttond
                    steamos-reset
                    steamos-systemreport
                    steamos-tweak-mtu-probing
                    strace
                    sudo
                    svt-av1
                    syndication
                    syntax-highlighting
                    systemd
                    systemd-libs
                    systemd-sysvcompat
                    systemsettings
                    taglib
                    talloc
                    tar
                    tcl
                    tdb
                    tevent
                    threadweaver
                    tinysparql
                    tk
                    tmux
                    tpm2-tss
                    trace-cmd
                    tree
                    tslib
                    ttf-dejavu
                    ttf-hack
                    ttf-twemoji-default
                    tzdata
                    udisks2
                    umr
                    unrar
                    unzip
                    upower
                    usbhid-gadget-passthru
                    usbutils
                    util-linux
                    util-linux-libs
                    v4l-utils
                    vapoursynth
                    verdict
                    vid.stab
                    vim
                    vim-runtime
                    vkmark
                    vlc
                    vmaf
                    volume_key
                    steamfork/vpower
                    vulkan-headers
                    vulkan-icd-loader
                    steamfork/vulkan-radeon
                    vulkan-tools
                    steamfork/vulkan-virtio
                    wakehook
                    wayland
                    wayland-utils
                    webrtc-audio-processing
                    wget
                    which
                    wireguard-tools
                    wireless-regdb
                    wireless_tools
                    wireplumber
                    wpa_supplicant
                    x264
                    x265
                    xbindkeys
                    xbitmaps
                    xcb-proto
                    xcb-util
                    xcb-util-cursor
                    xcb-util-errors
                    xcb-util-image
                    xcb-util-keysyms
                    xcb-util-renderutil
                    xcb-util-wm
                    xdg-dbus-proxy
                    xdg-desktop-portal
                    xdg-desktop-portal-gtk
                    xdg-desktop-portal-kde
                    xdg-user-dirs
                    xdg-utils
                    xdotool
                    xf86-input-libinput
                    xf86-video-amdgpu
                    xkeyboard-config
                    xorg-fonts-encodings
                    xorg-server
                    xorg-server-common
                    xorg-setxkbmap
                    xorg-xauth
                    xorg-xdpyinfo
                    xorg-xhost
                    xorg-xkbcomp
                    xorg-xmessage
                    xorg-xprop
                    xorg-xrandr
                    xorg-xrdb
                    xorg-xset
                    xorg-xsetroot
                    xorg-xwayland
                    xorg-xwininfo
                    xorgproto
                    xsettingsd
                    xterm
                    xvidcore
                    xxhash
                    xz
                    yajl
                    zenity-gtk3
                    zeromq
                    zimg
                    zip
                    zix
                    zlib
                    zram-generator
                    zsh
                    zstd
                    zxing-cpp
"

export UI_BOOTSTRAP="${STEAMOS_PKGS}
                  bc
                  ectool
                  hunspell-en_us
                  steamfork/inputplumber
                  kdegraphics-thumbnailers
                  kwrite
                  steamfork/lib32-vulkan-intel
                  libcap.so
                  libdisplay-info.so
                  libliftoff.so
                  libpipewire
                  libva-utils
                  libxkbcommon.so
                  openvr
                  pipewire-v4l2
                  pkgconf
                  plymouth
                  print-manager
                  python-build
                  python-installer
                  python-setuptools
                  python-wheel
                  ryzenadj
                  steamfork/steam-powerbuttond
                  steamfork-customizations
		  steamfork-theme
		  steamfork-sddm
                  steamfork-device-support
                  steamfork-keyring
                  vlc
                  steamfork/vulkan-intel
                  wlroots
                  wlr-randr
                  xorg-xwayland
                  zenity"
export POSTCOPY_BIN_EXECUTION=""
