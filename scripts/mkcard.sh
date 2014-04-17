#! /bin/sh
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

echo CYLINDERS – $CYLINDERS

{
echo ,9,0x0C,*
echo ,,,-
} | sfdisk -D -H 255 -S 63 -C $CYLINDERS $DRIVE

umount ${DRIVE}1
mkfs.vfat -F 32 -n boot ${DRIVE}1

umount ${DRIVE}2
mke2fs -j -L rootfs ${DRIVE}2 
