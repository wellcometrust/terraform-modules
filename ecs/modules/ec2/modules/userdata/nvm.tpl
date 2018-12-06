Content-Type: multipart/mixed; boundary="==BOUNDARY=="
MIME-Version: 1.0

--==BOUNDARY==
Content-Type: text/cloud-boothook; charset="us-ascii"

# Create /nvm folder
cloud-init-per once mkdir_nvm mkdir -p ${nvm_host_path}

# Format nvm volume
cloud-init-per once format_nvm mkfs -t ext4 ${nvm_volume_id}

# Add /nvm to fstab
cloud-init-per once mount_nvm echo -e '${nvm_volume_id} ${nvm_host_path} ext4 defaults,nofail 0 2' >> /etc/fstab

# Mount all
mount -a

--==BOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
# Set any ECS agent configuration options
cat << EOF > /etc/ecs/ecs.config

ECS_CLUSTER=${cluster_name}
ECS_INSTANCE_ATTRIBUTES={"nvm.volume":"${nvm_volume_id}"}

EOF
--==BOUNDARY==--