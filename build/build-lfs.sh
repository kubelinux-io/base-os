#!/bin/bash
set -e

cd $LFS

# Build essential tools
bash build-binutils.sh
bash build-gcc.sh
bash build-kernel.sh
bash build-systemd.sh

echo "LFS build complete!"