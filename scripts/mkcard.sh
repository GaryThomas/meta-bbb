#! /bin/sh
# (C) 2016, MLB Associates

DRIVE=$1

# Unmount disk otherwise fdisk won't take
umount ${DRIVE}1 >/dev/null 2>&1
umount ${DRIVE}2 >/dev/null 2>&1

# Erase old label
dd if=/dev/zero of=${DRIVE} bs=1024 count=8

# Create partitions
parted -s ${DRIVE} unit MIB -- mklabel msdos
parted -s ${DRIVE} unit MIB -- mkpart primary fat32 4 128
parted -s ${DRIVE} unit MIB -- set 1 boot on
parted -s ${DRIVE} unit MiB -- mkpart primary ext2 132 -1s
partprobe ${DRIVE}
sfdisk -l ${DRIVE}

umount ${DRIVE}1 >/dev/null 2>&1
mkfs.vfat -F 32 -n boot ${DRIVE}1

umount ${DRIVE}2 >/dev/null 2>&1
mke2fs -j -F -L rootfs ${DRIVE}2
