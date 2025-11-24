# --- Identify your block device ---
lsblk
# Lists all disks and mount points. Find your unmounted block storage (e.g. /dev/vdb).

# --- Install encryption tools ---
sudo apt update && sudo apt install -y cryptsetup
# Installs LUKS encryption utilities.

# --- Initialize LUKS encryption on the disk ---
sudo cryptsetup luksFormat /dev/vdb
# WARNING: This erases all data on /dev/vdb.
# Creates an encrypted LUKS container and writes a header to the disk.
# You’ll be asked to confirm and enter a passphrase.

# --- Unlock (open) the encrypted volume ---
sudo cryptsetup open /dev/vdb encrypted
# Decrypts the LUKS header and maps it to /dev/mapper/encrypted.
# The system now sees /dev/mapper/encrypted as a normal unencrypted block device.

# --- Format the decrypted layer ---
sudo mkfs.ext4 /dev/mapper/encrypted
# Formats the decrypted device with ext4 filesystem.

# --- Mount the encrypted volume ---
sudo mkdir /mnt/encrypted
sudo mount /dev/mapper/encrypted /mnt/encrypted
# Creates a mount point and mounts the new filesystem.

# --- Verify ---
lsblk
# Example output:
# vdb                   252:16   0 600G  0 disk
# └─encrypted           253:0    0 600G  0 crypt /mnt/encrypted

# --- Make it persistent across reboots ---
# 1. Add an entry in /etc/crypttab
# This file defines which encrypted volumes to unlock at boot.

echo "encrypted /dev/vdb none luks" | sudo tee -a /etc/crypttab

# Syntax:
# <name> <device> <password or 'none'> <options>
# In this case:
#   name       = "encrypted" (creates /dev/mapper/encrypted)
#   device     = /dev/vdb (the physical encrypted disk)
#   none       = means prompt for passphrase at boot
#   luks       = tells systemd it’s a LUKS device

# 2. Add an entry in /etc/fstab so it mounts automatically after unlocking.
echo "/dev/mapper/encrypted /mnt/encrypted ext4 defaults 0 2" | sudo tee -a /etc/fstab

# Syntax:
# <device> <mountpoint> <type> <options> <dump> <pass>
# “defaults” uses standard mount options.

# --- Test it ---
sudo umount /mnt/encrypted
sudo cryptsetup close encrypted
sudo systemctl daemon-reexec
sudo systemctl restart systemd-cryptsetup@encrypted.service
sudo mount -a
# This sequence simulates a reboot:
# It reopens and mounts your encrypted volume using /etc/crypttab and /etc/fstab settings.

# After a real reboot, you’ll be prompted for your passphrase to unlock /dev/vdb at boot.
# Once entered, it mounts automatically to /mnt/encrypted and your Git repos or other files are accessible.
