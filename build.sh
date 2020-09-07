echo
echo "Setup"
echo
export LOCALVERSION="-Pop-Kernel-${branch_name}/${last_commit}"
mkdir -p out
export ARCH=arm64
export SUBARCH=arm64
make O=out clean
make O=out mrproper

echo
echo "Issue Build Commands"
echo
export CROSS_COMPILE=/home/andrea/gcc10/arm64-gcc//bin/aarch64-elf-
export CROSS_COMPILE_ARM32=/home/andrea/gcc10/arm32-gcc//bin/arm-eabi-

echo
echo "Set DEFCONFIG"
echo 
make O=out shadow_defconfig

echo
echo "Build The Good Stuff"
echo 
make O=out -j$(nproc --all)

rm ./AnyKernel3/Image.gz-dtb
cp ./out/arch/arm64/boot/Image.gz-dtb ./AnyKernel3
cd AnyKernel3
rm ./Pop_kernel-bullhead-O-rx-x.zip
zip -r9 Pop_kernel-bullhead-O-rx-x.zip * -x .git README.md *placeholder
