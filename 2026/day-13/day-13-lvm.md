# Day 13 – LVM on AWS Ubuntu

## Environment
- Platform: AWS EC2
- OS: Ubuntu
- Storage: EBS Volume

---

## Commands Used

### Check Disks
lsblk  
df -h  
pvs  
vgs  
lvs  

### Create Physical Volume
pvcreate /dev/xvdb  
pvs  

### Create Volume Group
vgcreate devops-vg /dev/xvdb  
vgs  

### Create Logical Volume
lvcreate -L 500M -n app-data devops-vg  
lvs  

### Format & Mount
mkfs.ext4 /dev/devops-vg/app-data  
mkdir -p /mnt/app-data  
mount /dev/devops-vg/app-data /mnt/app-data  
df -h /mnt/app-data  

### Extend Logical Volume
lvextend -L +200M /dev/devops-vg/app-data  
resize2fs /dev/devops-vg/app-data  
df -h /mnt/app-data  

---

## What I Learned
1. AWS EBS volumes can be directly used with LVM.
2. Logical Volumes can be extended live without downtime.
3. LVM is ideal for cloud production systems.

---

## Status
✅ Completed Day 13 – LVM
