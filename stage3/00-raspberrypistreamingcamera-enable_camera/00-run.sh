#!/bin/bash -e

# copy files directory on root partition for temp usage
cp -r files ${ROOTFS_DIR}/
ls -ltr
ls -ltr files
