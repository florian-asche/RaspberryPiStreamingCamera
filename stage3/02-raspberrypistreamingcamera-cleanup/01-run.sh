#!/bin/bash -e

on_chroot << EOF
# apt
apt-get -y install localepurge
localepurge
apt-get -y remove --purge localepurge
apt-get -y remove --purge avahi-daemon build-essential dosfstools lua5.1 luajit manpages-dev
apt-get -y autoremove --purge
apt-get clean

aptitude update
aptitude clean
EOF
