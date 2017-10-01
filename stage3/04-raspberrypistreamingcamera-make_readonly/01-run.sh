#!/bin/bash -e

on_chroot << EOF
# Readonly - First get rid of some unnecessary pagkages.
apt-get -y remove --purge cron logrotate  dphys-swapfile
apt-get -y autoremove --purge

# Readonly - Remove rsyslog and install a memory resident variant
apt-get -y remove --purge rsyslog
apt-get -y install busybox-syslogd

# Readonly - Now remap some folders to memory temp space
rm -rf /var/lib/dhcp/
rm -rf /var/spool
rm -rf /var/lock
rm -rf /var/log
rm -rf /var/run
rm /etc/resolv.conf
ln -s /tmp /var/lib/dhcp
ln -s /tmp /var/spool
ln -s /tmp /var/lock
ln -s /tmp /var/log
ln -s /tmp /var/run
ln -s /tmp/resolv.conf /etc/resolv.conf

# Readonly - configure the boot options to be read-only on next boot
#mount -o remount rw /boot
#echo "dwc_otg.lpm_enable=0 console=serial0,115200 console=tty1 root=/dev/mmcblk0p2 rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait fastboot noswap" | tee /boot/cmdline.txt

# Readonly - install new fstab
cp files/fstab /etc/fstab

# Readonly - remove swap
rm -rf /var/swap

# Readonly - reboot your raspberry pi here, check if you are read only
reboot
EOF
