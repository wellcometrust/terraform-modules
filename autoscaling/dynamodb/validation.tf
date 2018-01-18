# This file does some validation of the variables provided.
#
# In particular, it checks that if you have enable_read_capacity = true,
# you've passed the other parameters required, and similar for writes.
#
# It's based on an idea from this blog post:
# https://www.linkedin.com/pulse/devops-how-do-assertion-test-terraform-template-jamie-nelson/

resource "null_resource" "check_read_target_utilization" {
  count = "${var.enable_read_scaling ? (var.read_target_utilization == "" ? 1 : 0) : 0}"
  "ERROR: If enable_read_scaling=true, you need to provide read_target_utilization" = true
}

resource "null_resource" "check_read_min_capacity" {
  count = "${var.enable_read_scaling ? (var.read_min_capacity == "" ? 1 : 0) : 0}"
  "ERROR: If enable_read_scaling=true, you need to provide read_min_capacity" = true
}

resource "null_resource" "check_read_max_capacity" {
  count = "${var.enable_read_scaling ? (var.read_max_capacity == "" ? 1 : 0) : 0}"
  "ERROR: If enable_read_scaling=true, you need to provide read_max_capacity" = true
}

resource "null_resource" "check_write_target_utilization" {
  count = "${var.enable_write_scaling ? (var.write_target_utilization == "" ? 1 : 0) : 0}"
  "ERROR: If enable_write_scaling=true, you need to provide write_target_utilization" = true
}

resource "null_resource" "check_write_min_capacity" {
  count = "${var.enable_write_scaling ? (var.write_min_capacity == "" ? 1 : 0) : 0}"
  "ERROR: If enable_write_scaling=true, you need to provide write_min_capacity" = true
}

resource "null_resource" "check_write_max_capacity" {
  count = "${var.enable_write_scaling ? (var.write_max_capacity == "" ? 1 : 0) : 0}"
  "ERROR: If enable_write_scaling=true, you need to provide write_max_capacity" = true
}

