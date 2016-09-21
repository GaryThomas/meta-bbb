#! /bin/sh
# (C) 2016, MLB Associates
# (c) 2009 Graeme Gregory
# modified by Steve Sakoman
# This script is GPLv3 licensed!

DRIVE=$1

dd if=/dev/zero of=$DRIVE bs=1024 count=1024

SIZE=`fdisk -l $DRIVE | grep Disk | awk '{print $5}'`

echo DISK SIZE – $SIZE bytes

CYLINDERS=`echo $SIZE/255/63/512 | bc`

# Unmount disk otherwise fdisk won't take
umount ${DRIVE}1
umount ${DRIVE}2

# Create partitions
parted -s ${DRIVE} unit MIB -- mklabel msdos
parted -s ${DRIVE} unit MIB -- mkpart primary fat32 4 128
parted -s ${DRIVE} unit MIB -- set boot 1 on
parted -s ${DRIVE} unit MiB -- mkpart primary ext2 132 -1s
partprobe ${DRIVE}
sfdisk -l ${DRIVE}

umount ${DRIVE}1
mkfs.vfat -F 32 -n boot ${DRIVE}1

umount ${DRIVE}2
mke2fs -j -L rootfs ${DRIVE}2 
