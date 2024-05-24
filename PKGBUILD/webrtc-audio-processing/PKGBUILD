# Maintainer: Jan Alexander Steffens (heftig) <heftig@archlinux.org>

pkgname=webrtc-audio-processing-1
pkgver=1.3
pkgrel=2
pkgdesc="AudioProcessing library based on Google's implementation of WebRTC"
url="https://freedesktop.org/software/pulseaudio/webrtc-audio-processing/"
arch=(x86_64)
license=(custom)
depends=(
  abseil-cpp
  gcc-libs
)
makedepends=(
  git
  meson
)
provides=(libwebrtc-audio-{coding,processing}-${pkgver%%.*}.so)
_commit=8e258a1933d405073c9e6465628a69ac7d2a1f13  # tags/v1.3^0
source=("git+https://gitlab.freedesktop.org/pulseaudio/webrtc-audio-processing.git#commit=$_commit")
b2sums=('SKIP')

pkgver() {
  cd webrtc-audio-processing
  git describe --tags | sed 's/^v//;s/[^-]*-g/r&/;s/-/+/g'
}

prepare() {
  cd webrtc-audio-processing
}

build() {
  local meson_options=(
    # must match abseil
    -D cpp_std=c++17
  )

  arch-meson webrtc-audio-processing build "${meson_options[@]}"
  meson compile -C build
}

check() {
  meson test -C build --print-errorlogs
}

package() {
  meson install -C build --destdir "$pkgdir"
  install -Dt "$pkgdir/usr/share/licenses/$pkgname" -m644 webrtc-audio-processing/COPYING
}

# vim:set sw=2 sts=-1 et:
