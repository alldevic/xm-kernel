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
../scripts/config --set-val  DEBUG_INFO_DWARF5     n
../scripts/config --disable  DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
echo "DONE!"