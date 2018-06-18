RELEASE_TYPE: patch

This release fixes a bug in `dlami_asg`, where instances would fail to start
because they were trying to install an invalid version of s3contents.

Additionally, this release pins _all_ the Python dependencies installed on
a deep learning image, so dependencies should be consistent between reboots.
