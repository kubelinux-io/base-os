#!/bin/bash
set -e  # Stop on error

# Define environment
export LFS=/mnt/lfs
export LFS_TGT=$(uname -m)-lfs-linux-gnu
export PATH=$LFS/tools/bin:$PATH

# Extract source and enter directory
cd $LFS/sources
tar -xf binutils-*.tar.xz
cd binutils-*

# Create a separate build directory
mkdir -v build
cd build

# Configure for cross-compilation
../configure --prefix=$LFS/tools \
             --with-sysroot=$LFS \
             --target=$LFS_TGT \
             --disable-nls \
             --disable-werror

# Compile and install
make -j$(nproc)
make install

# Cleanup
cd $LFS/sources
rm -rf binutils-*

echo "Binutils build complete!"
