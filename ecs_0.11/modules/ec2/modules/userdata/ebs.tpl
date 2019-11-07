Content-Type: multipart/mixed; boundary="==BOUNDARY=="
MIME-Version: 1.0

--==BOUNDARY==
Content-Type: text/cloud-boothook; charset="us-ascii"

# Create /ebs folder
cloud-init-per once mkdir_ebs mkdir -p ${ebs_host_path}

# Format ebs volume
cloud-init-per once format_ebs mkfs -t ext4 ${ebs_volume_id}

# Add /ebs to fstab
cloud-init-per once mount_ebs echo -e '${ebs_volume_id} ${ebs_host_path} ext4 defaults,nofail 0 2' >> /etc/fstab

# Mount all
mount -a

--==BOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash
# Set any ECS agent configuration options
cat << EOF > /etc/ecs/ecs.config

ECS_CLUSTER=${cluster_name}
ECS_INSTANCE_ATTRIBUTES={"ebs.volume":"${ebs_volume_id}"}

EOF
--==BOUNDARY==--