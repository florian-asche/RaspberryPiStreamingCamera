#!/bin/bash -e

on_chroot << EOF
cd files
./script.sh
EOF
