#!/bin/bash -e

on_chroot << EOF
cd /installfiles/
./install.sh
EOF
