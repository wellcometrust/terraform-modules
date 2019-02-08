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
Content-Type: text/x-shellscript; charset="us-ascii"

#!/bin/bash

# Install monitoring dependencies
sudo yum install unzip wget perl-Switch perl-DateTime perl-Sys-Syslog perl-LWP-Protocol-https perl-Digest-SHA -y

# Download, unpack monitoring scripts
wget -O ~ec2-user/CloudWatchMonitoringScripts-1.2.2.zip http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.2.zip
cd ~ec2-user && unzip CloudWatchMonitoringScripts-1.2.2.zip
chown ec2-user:ec2-user ~ec2-user/aws-scripts-mon
rm CloudWatchMonitoringScripts-1.2.2.zip

# Setup cron to run them
crontab -l > ~ec2-user/mycron
echo "*/5 * * * * ~ec2-user/aws-scripts-mon/mon-put-instance-data.pl --disk-space-util --disk-path=/ --from-cron" >> ~ec2-user/mycron
echo "*/5 * * * * ~ec2-user/aws-scripts-mon/mon-put-instance-data.pl --mem-used --mem-avail --swap-used" >> ~ec2-user/mycron
crontab ~ec2-user/mycron

EOF
--==BOUNDARY==--