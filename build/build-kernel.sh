#!/bin/bash
set -e

# Define environment
export PATH=$LFS/tools/bin:$PATH

# Extract kernel source
cd $LFS/sources
tar -xf linux-*.tar.xz
cd linux-*

# Configure the kernel
make mrproper
make defconfig

# Compile and install
make -j$(nproc)
make modules_install INSTALL_MOD_PATH=$LFS
make headers_install INSTALL_HDR_PATH=$LFS/usr

# Copy kernel to boot directory
cp -v arch/x86/boot/bzImage $LFS/boot/vmlinuz-linux

# Cleanup
cd $LFS/sources
rm -rf linux-*

echo "Linux Kernel build complete!"
