FROM ubuntu:24.04

WORKDIR /project

RUN DEBIAN_FRONTEND=noninteractive apt update
RUN DEBIAN_FRONTEND=noninteractive apt install -y \
    software-properties-common \
    wget \
    file \
    pkg-config \
    git \
    curl \
    fuse \
    libfuse2 \
    zlib1g-dev \
    libusb-1.0-0-dev \
    ca-certificates \
    build-essential \
    libgl-dev \
    libxkbcommon-x11-dev \
    libxcb-icccm4-dev \
    libxcb-image0-dev \
    libxcb-keysyms1-dev \
    libxcb-randr0-dev \
    libxcb-render-util0-dev \
    libxcb-sync-dev \
    libdbus-1-dev \
    libmd4c-dev \
    libegl-dev \
    libxcb-xfixes0-dev \
    libsm-dev \
    libice-dev \
    libxcb-glx0-dev \
    libdrm-dev \
    libx11-xcb-dev \
    libopengl-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN DEBIAN_FRONTEND=noninteractive apt update
RUN DEBIAN_FRONTEND=noninteractive apt -y install \
    qt6-base-dev \
    qt6-wayland-dev \
    qt6-3d-dev \
    qt6-declarative-dev \
    qt6-serialport-dev \
    qt6-shadertools-dev \
    qt6-svg-dev \
    qt6-tools-dev \
    qt6-5compat-dev \
    qml6-module-*

RUN wget https://github.com/linuxdeploy/linuxdeploy/releases/download/1-alpha-20250213-2/linuxdeploy-x86_64.AppImage \
    -O /usr/bin/linuxdeploy && chmod +x /usr/bin/linuxdeploy

RUN wget https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/1-alpha-20250213-1/linuxdeploy-plugin-qt-x86_64.AppImage \
    -O /usr/bin/linuxdeploy-plugin-qt && chmod +x /usr/bin/linuxdeploy-plugin-qt

RUN git config --global --replace-all safe.directory '*'

COPY init.sh /init.sh

ENTRYPOINT ["/init.sh"]
