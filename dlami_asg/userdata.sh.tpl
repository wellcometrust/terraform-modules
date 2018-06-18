#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o xtrace

# Create jupyter user
adduser ${notebook_user} --gecos "" --disabled-password

# Write config file
mkdir /home/${notebook_user}/.jupyter
cat << EOF > /home/${notebook_user}/.jupyter/jupyter_notebook_config.py
${jupyter_notebook_config}
EOF

# Select the version of pip for our default environment.
PIP=/home/ubuntu/anaconda3/envs/${default_environment}/bin/pip

cat << EOF > /home/${notebook_user}/requirements.txt
${requirements}
EOF

$PIP install --upgrade pip
$PIP install /home/${notebook_user}/requirements.txt > /home/${notebook_user}/pip_install.log 2>&1

# Start notebook server
runuser --login ${notebook_user} --command '/home/ubuntu/anaconda3/bin/jupyter notebook'
