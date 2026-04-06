#!/bin/bash
#Script to build buildroot configuration and restore updated LIBGPIOD V2 Library
#Author: Siddhant Jajoo, modified for the RPi 4 by Jordan Kooyman
source shared.sh
EXTERNAL_REL_BUILDROOT=../base_external
git submodule init
git submodule sync
git submodule update
set -e 
cd `dirname $0`
if [ ! -e buildroot/.config ]
then
    echo "MISSING BUILDROOT CONFIGURATION FILE"
    if [ ! -d buildroot/package/libgpiod ]; then
        echo "ERROR: buildroot submodule did not initialize correctly"
        exit 1
    fi
    ./restore-libgpiod.sh
    if [ -e ${AESD_MODIFIED_DEFCONFIG} ]
    then
        echo "USING ${AESD_MODIFIED_DEFCONFIG}"
        make -C buildroot defconfig BR2_EXTERNAL=${EXTERNAL_REL_BUILDROOT} \
            BR2_DEFCONFIG=${AESD_MODIFIED_DEFCONFIG_REL_BUILDROOT}
    else
        echo "Run ./save_config.sh to save this as the default configuration"
        make -C buildroot raspberrypi4_64_defconfig BR2_EXTERNAL=${EXTERNAL_REL_BUILDROOT}
    fi
else
    echo "USING EXISTING BUILDROOT CONFIG"
    make -C buildroot BR2_EXTERNAL=${EXTERNAL_REL_BUILDROOT}
fi
