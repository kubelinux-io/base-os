#!/bin/bash
set -e

# Define environment
export LFS=/mnt/lfs
export PATH=$LFS/tools/bin:$PATH

# Extract systemd source
cd $LFS/sources
tar -xf systemd-*.tar.xz
cd systemd-*

# Configure systemd
mkdir -v build
cd build

meson --prefix=/usr \
      --sysconfdir=/etc \
      --localstatedir=/var \
      -Ddefault-hierarchy=unified ..

# Compile and install
ninja
ninja install

# Enable systemd as init
ln -sf /lib/systemd/systemd $LFS/init

# Cleanup
cd $LFS/sources
rm -rf systemd-*

echo "Systemd build complete!"
