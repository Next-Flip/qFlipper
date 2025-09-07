#!/bin/bash

set -euxo pipefail;

TARGET="qFlipper"
BUILDDIR="build"
APPDIR_PREFIX="$PWD/$BUILDDIR/AppDir/usr"

LIBSSL3_OVERRIDE="$(ldconfig -p | grep x86-64 | grep -oP '/[^\s]+/libssl.so.3' | head -n1)"

export OUTPUT="$TARGET-x86_64.AppImage"
export QML_SOURCES_PATHS="$PWD/application"
export EXTRA_QT_PLUGINS="waylandcompositor"
export EXTRA_PLATFORM_PLUGINS="libqwayland-egl.so;libqwayland-generic.so"

mkdir -p "$BUILDDIR" && cd "$BUILDDIR"

qmake6 "../$TARGET.pro" -spec linux-g++ "CONFIG+=release qtquickcompiler" PREFIX="$APPDIR_PREFIX"
make qmake_all
make -j"$(nproc)"
make install

linuxdeploy --appdir=AppDir -o appimage \
    --custom-apprun="../installer-assets/appimage/AppRun" \
    --library="$LIBSSL3_OVERRIDE" \
    --plugin qt
