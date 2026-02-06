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
<img width="818" height="374" alt="Screenshot 2026-02-05 214935" src="https://github.com/user-attachments/assets/c8cb5594-f863-441a-bbc1-bb7c0c36d9d8" />
<img width="703" height="189" alt="Screenshot 2026-02-05 215834" src="https://github.com/user-attachments/assets/c1e3e04b-7b77-4f2d-8e6d-6e47e3985253" />
<img width="1164" height="145" alt="Screenshot 2026-02-05 220257" src="https://github.com/user-attachments/assets/17a47d2e-7fc1-4448-8fdc-0003533a55cd" />
<img width="894" height="300" alt="Screenshot 2026-02-05 220611" src="https://github.com/user-attachments/assets/8c5034f6-755c-43f2-a743-7547f0ed35c5" />
<img width="1369" height="81" alt="Screenshot 2026-02-05 225632" src="https://github.com/user-attachments/assets/218cf6f5-c157-4b44-a0a4-da381329ba2d" />
<img width="1042" height="448" alt="Screenshot 2026-02-05 225646" src="https://github.com/user-attachments/assets/5a99456c-69e1-4e87-bb65-f5206a69a9c3" />
<img width="690" height="298" alt="Screenshot 2026-02-05 220225" src="https://github.com/user-attachments/assets/cf017410-7d73-4bc4-9bb7-aae81aaae303" />

