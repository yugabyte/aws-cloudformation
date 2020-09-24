#!/bin/bash
# Format the NVMe based instance store disks available on instances
# like m5d, i3 etc, and add fstab entries for
# them. https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/InstanceStorage.html#instance-store-volumes

set -o pipefail -o errexit

yb_data_path="/home/${USER}/yugabyte-db/data"
disk_dir_prefix="ephemeral-nvme"
device_by_id_glob="/dev/disk/by-id/nvme-Amazon_EC2_NVMe_Instance_Storage_*-ns-1"

# Exit if there are no devices
if ! stat -c "%n" ${device_by_id_glob}; then
  exit 0
fi

idx=0
# Taken reference from an answer by MLu, licensed under CC BY-SA 4.0
# https://serverfault.com/a/952864/433550
for device in ${device_by_id_glob}; do
  sudo mkfs -t xfs -f "${device}"
  mount_path="${yb_data_path}/${disk_dir_prefix}${idx}"
  mkdir -p "${mount_path}"
  uuid="$(sudo blkid "${device}" -o value -s UUID)"
  echo "UUID=${uuid} ${mount_path} xfs defaults,noatime,nofail,allocsize=4m 0 2" \
    | sudo tee -a /etc/fstab
  idx=$(( idx + 1 ))
done

sudo mount -a
sudo chown -R "${USER}:${USER}" "${yb_data_path}/${disk_dir_prefix}"*
