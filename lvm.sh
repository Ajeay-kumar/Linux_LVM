#To Create LVM

#First we need to add two new vertual hard disks and create pv's in it

#The lsblk command in Linux is used to list information about all available
#1 block devices on the system.

command: "lsblk"

#2 Create Physical volumes(PV's)

sudo pvcreate /dev/sdc
sudo pvcreate /dev/sdd

#3 Create Volume Groups(VG's)

sudo vgcreate vg-1 /dev/sdc /dev/sdd

#4 Create Logical Volume(LV's)

sudo lvcreate -n lv-1 -L+2G vg-1

###5 Create mount point and mount it

sudo mkdir /mnt/lvdata
sudo mount /dev/vg-1/lv-1 /mnt/lvdata

#6 Add some files and check 

sudo touch /mnt/lvdata/file{1..100}
sudo df -h /mnt/lvdata

#unmount and expand the size

sudo umount /mnt/lvdata

#Expand lv size

sudo lvextend -L+3G /dev/vg-1/lv-1

#resize lv

sudo resize2fs /dev/vg-1/lv-1

#mount the extended lv again

sudo mount /dev/vg-1/lv-1 /mnt/lvdata

#To verify :

sudo df -h /mnt/lvdata

