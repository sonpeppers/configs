# Paul Epperson

# Info about operating system (uname)
# -----------------------------------
# uname -o, --operating-system:  GNU/Linux
#       -s, --kernel-name:       Linux
#       -r, --kernel-release:    4.8.0-41-generic
#       -v, --kernel-version:    #44~16.04.1-Ubuntu SMP
#       -m, --machine:           x86_64
#       -p, --processor:         x86_64
#       -i, --hardware-platform: x86_64

# Info about machine (lscpu, sudo lshw)
# ------------------------------------------------
# sudo lshw | grep vendor:  Acer
#                  product: Aspire V7-582PG
#                           ...
#                           Intel(R) Core(TM) i5-4200U CPU @ 1.60 GHz
#                           ...
# lscpu: x86_64
#        Little Endian
#        4 CPU's
#        2 threads per core
#        32K L1 data cache
#        32K L1 instruction

# Useful commands for creating bootable partition (e.g. 1 per flash drive)
# ------------------------------------------------------------------------
# lsusb:  display usb info
# lsblk:  display device info
# umount: unmount a device (e.g. sudo umount /dev/sd??)
# dd:     zero out partition (e.g. if=/dev/zero of=/dev/sd??)
# mkfs:   assign device a filesystem (e.g. to ext4 or ntfs)
# dd:     copy file to partition (e.g. sudo dd bs=4M if=*.iso of=/dev/sd??)
# sync:   use to enforce write completion of dd
#
# Example execution
# -----------------
# TODO

# Note: sudo do-release-upgrade is unbearably slow, just do clean installs

################################################################################

# TODO
