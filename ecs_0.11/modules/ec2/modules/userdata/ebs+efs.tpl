Content-Type: multipart/mixed; boundary="==BOUNDARY=="
MIME-Version: 1.0

--==BOUNDARY==
Content-Type: text/cloud-boothook; charset="us-ascii"

# Install nfs-utils
cloud-init-per once yum_update yum update -y
cloud-init-per once install_efs_utils yum install -y amazon-efs-utils

# Create /efs folder
cloud-init-per once mkdir_efs mkdir /efs

# Mount /efs
cloud-init-per once mount_efs echo -e '${efs_fs_id}:/ ${efs_host_path} efs defaults,_netdev 0 0' >> /etc/fstab

# Create /ebs folder
cloud-init-per once mkdir_ebs mkdir /ebs

# Format ebs volume
cloud-init-per once format_ebs mkfs -t ext4 ${ebs_volume_id}

# Add /ebs to fstab
cloud-init-per once mount_ebs echo -e '${ebs_volume_id} ${ebs_host_path} ext4 defaults,nofail 0 2' >> /etc/fstab

# Mount all
mount -a

--==BOUNDARY==
Content-Type: text/x-shellscript; charset="us-ascii"

cat << EOF > /etc/ecs/ecs.config

ECS_CLUSTER=${cluster_name}
ECS_INSTANCE_ATTRIBUTES={"ebs.volume":"${ebs_volume_id}", "efs.volume":"${efs_fs_id}"}

EOF

--==BOUNDARY==--