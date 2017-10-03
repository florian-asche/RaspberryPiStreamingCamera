#!/bin/bash -e

# install all files for installation
mkdir ${ROOTFS_DIR}/installfiles/

install -m 755 files/install.sh ${ROOTFS_DIR}/installfiles/
install -m 755 files/make_me_readonly.sh ${ROOTFS_DIR}/installfiles/
install -m 644 files/fstab ${ROOTFS_DIR}/installfiles/
install -m 644 files/interfaces ${ROOTFS_DIR}/installfiles/
install -m 644 files/RTSP-Server.service ${ROOTFS_DIR}/installfiles/
install -m 644 files/uv4l-raspicam.conf ${ROOTFS_DIR}/installfiles/
install -m 644 files/uv4l-raspicam_original_17.conf ${ROOTFS_DIR}/installfiles/
install -m 644 files/uv4l-server.conf ${ROOTFS_DIR}/installfiles/
