# Zest Kernel (reBORN) Build Script
# Variant: bullhead
#
# Copyright (c) 2018, Laster K.. All rights reserved.

# Exports
export ARCH=arm64
export SUBARCH=arm
if [ -z ${CROSS_COMPILE:?x} ]; then
  export CROSS_COMPILE=/home/laster/android/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin/aarch64-linux-android-
fi

# Prepare
rm -rf out/
make clean
rm -rf ~/zestkernel-bullhead.log

# Build
clear
make zest-bullhead_defconfig
make -j19 | tee -a ~/zestkernel-bullhead.log
