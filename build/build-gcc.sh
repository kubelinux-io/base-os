#!/bin/bash
set -e

# Define environment
export LFS_TGT=$(uname -m)-lfs-linux-gnu
export PATH=$LFS/tools/bin:$PATH

# Extract GCC source
cd $LFS/sources
tar -xf gcc-*.tar.xz
cd gcc-*

# Extract necessary dependencies
tar -xf mpfr-*.tar.xz && mv -v mpfr-* mpfr
tar -xf gmp-*.tar.xz && mv -v gmp-* gmp
tar -xf mpc-*.tar.gz && mv -v mpc-* mpc

# Create build directory
mkdir -v build
cd build

# Configure GCC
../configure --target=$LFS_TGT \
             --prefix=$LFS/tools \
             --with-glibc-version=2.38 \
             --with-sysroot=$LFS \
             --with-newlib \
             --without-headers \
             --enable-initfini-array \
             --disable-nls \
             --disable-shared \
             --disable-multilib \
             --disable-decimal-float \
             --disable-threads \
             --disable-libatomic \
             --disable-libgomp \
             --disable-libquadmath \
             --disable-libssp \
             --disable-libvtv \
             --disable-libstdcxx \
             --enable-languages=c,c++

# Compile and install
make -j$(nproc)
make install

# Cleanup
cd $LFS/sources
rm -rf gcc-*

echo "GCC build complete!"
