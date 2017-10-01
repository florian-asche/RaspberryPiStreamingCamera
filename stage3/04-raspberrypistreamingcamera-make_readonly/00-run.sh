#!/bin/bash -e

# copy files directory on root partition for temp usage
rm -rf ${ROOTFS_DIR}/files/
cp -r files ${ROOTFS_DIR}/
