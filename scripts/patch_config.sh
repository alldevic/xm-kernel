#! /bin/bash

cd /kernel/linux/config

# Disable *dbg.deb generation
echo -n "Disabling debug..."
../scripts/config --undefine GDB_SCRIPTS
../scripts/config --undefine DEBUG_INFO
../scripts/config --undefine DEBUG_INFO_SPLIT
../scripts/config --undefine DEBUG_INFO_REDUCED
../scripts/config --undefine DEBUG_INFO_COMPRESSED
../scripts/config --set-val  DEBUG_INFO_NONE       y
../scripts/config --disable  DEBUG_INFO_DWARF5
../scripts/config --disable  DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
echo "DONE!"

echo -n "Remove kernel/kheaders.ko..."
../scripts/config --disable  IKHEADERS
echo "DONE!"

# echo -n "Enable ZSTD modules compress..."
# ../scripts/config --disable  MODULE_COMPRESS_NONE
# ../scripts/config --enable   MODULE_COMPRESS_ZSTD
# ../scripts/config --enable   MODULE_DECOMPRESS
# echo "DONE!"

echo -n "Disable modules compress..."
../scripts/config --undefine MODULE_DECOMPRESS
../scripts/config --disable  MODULE_COMPRESS_ZSTD
../scripts/config --enable   MODULE_COMPRESS_NONE
echo "DONE!"

echo -n "Fix boot IMA warning..."
../scripts/config --enable    CONFIG_IMA_DISABLE_HTABLE
echo "DONE!"
