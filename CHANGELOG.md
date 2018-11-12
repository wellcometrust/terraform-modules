# CHANGELOG

## v13.1.0 - 2018-11-12

Allow custom domains to be created seperately from stages.

## v13.0.0 - 2018-11-10

Refactoring API GW module for further flexibility

## v12.1.1 - 2018-11-08

*module.rds.aws_rds_cluster_instance*

set `publicly_accessible  = true` to `false`

## v12.1.0 - 2018-11-06

This adds the `function_arn` output to the prebuilt Lambda modules.

## v12.0.0 - 2018-11-05

ECS modules redone to simplify rest/scaling approach

## v11.12.0 - 2018-11-02

Allow to optionally create lambdas in a VPC

## v11.11.0 - 2018-10-30

Adds support for optional PGP key for client_bucket_user

## v11.10.0 - 2018-10-29

Allow to optionally create TCP target groups for services

## v11.9.0 - 2018-10-09

Adds support for `command` and `mount_points` to the ecs single_container task definition.

## v11.8.1 - 2018-10-01

Fix a bug with calling a data block instead of resource for ecs iam roles

## v11.8.0 - 2018-09-13

Allow optional scaling of a gsi in a dynamo table

## v11.7.2 - 2018-08-29

And let the Jupyter notebook user in the dlami write to the EFS mount.

## v11.7.1 - 2018-08-29

Okay, but now with the dlami variables in the right place.

## v11.7.0 - 2018-08-29

Add userdata configuration to mount an EFS volume in the data science VMs
upon startup.

## v11.6.1 - 2018-08-24

This adds better error reporting to the `sqs` module, so it errors if
you set the `topic_count` variable incorrectly.

## v11.6.0 - 2018-07-31

Add cloudwatch alb alarm modules

## v11.5.0 - 2018-07-30

This adds an output for the `lambda` module, so that the `invoke_arn` property of the `aws_lambda_function` can be integrated with API Gateway.

## v11.4.1 - 2018-07-17

Modify SQS autoscaling to scale down on messages deleted <= 0 instead of messages visible on the queue.

## v11.4.0 - 2018-07-17

Fix computed map issue for rds

## v11.3.1 - 2018-07-16

Fix duplicate instance role policy names

## v11.3.0 - 2018-07-16

Update port mappings module in /ecs to presume awsvpc networking.

## v11.2.0 - 2018-07-16

Force specifying number of environment variavles when passing them to tasks

## v11.1.0 - 2018-07-04

Allow multiple containers in task definitions and add support for DAEMON tasks.

## v11.0.0 - 2018-06-27

Major overhaul of many modules.

*   `network`: Public & private subnets
*   `ec2`: Run Autoscaling groups with prebuilt modules for EBS/EFS
*   `ecs`: Support for fargate, private services, use of EFS/EBS from container host

Removed some unused and out of place modules.

## v10.3.1 - 2018-06-19

This release fixes a bug in `dlami_asg`, where instances would fail to start
because they were trying to install an invalid version of s3contents.

Additionally, this release pins _all_ the Python dependencies installed on
a deep learning image, so dependencies should be consistent between reboots.

## v10.3.0 - 2018-06-18

This release deprecates the following variables:

*   `config_vars_length` in `ecs/service/ecs_task`
*   `env_vars_length` in `ecs/service`
*   `env_vars_length` in `sqs_autoscaling_service`

Their existence was always a nasty hack around some Terraform interpolation
issues, and it looks like we can get rid of them.  They can be safely removed
with no effect.

## v10.2.3 - 2018-06-04

This change adds an `APP_NAME` environment variable to the task definition of tasks created with the `ecs` module. The `APP_NAME` variable is set to the value of the container uri used as the primary container in the service.

## v10.2.2 - 2018-05-30

Adds networkx to the default list of packages installed in the deep learning ami

## v10.2.1 - 2018-05-29

Adds [beautifulsoup4](https://www.crummy.com/software/BeautifulSoup/bs4/doc/) to the default list of packages installed in the deep learning ami

## v10.2.0 - 2018-05-10

Allow instances with both EBS and EFS volumes.

## v10.1.0 - 2018-05-08

This change adds the ability to set the ECS Service launch type to FARGATE

## v10.0.0 - 2018-05-08

This release makes spot price a mandatory variable.

## v9.5.0 - 2018-05-02

This release adds a `default_environment` parameter to the `dlami_asg` module,
which lets the user decide which environment we install packages in.

## v9.4.0 - 2018-05-02

This release adds a data science infra module.

## v9.3.0 - 2018-04-30

This release fixes an issue with adding tags to ASGs previouisly merged.

## v9.2.0 - 2018-04-26

This release adds a V2 ASG module intended to supersede the existing ECS only ASG description in the `ecs` module.

## Usage:

```hcl
module "test" {
  source = "../terraform-modules/ec2/asg"
  name   = "tf-asg-v2"

  image_id = "ami-0bc19972"
  key_name = "${var.key_name}"

  subnet_list = "${module.vpc.subnets}"
  vpc_id      = "${module.vpc.vpc_id}"
}
```

## v9.1.0 - 2018-04-25

This release adds the `log_retention_in_days` parameter to the following modules:

*   _ecs/service/ecs_task_
*   _ecs/service_
*   _ecs_script_task_
*   _lambda_
*   _sqs_autoscaling_service_
*   _userdata_

which controls the log retention policies for CloudWatch log groups.

It defaults to none (i.e. retain logs forever).

## v9.0.0 - 2018-04-24

This release adds a `dev_user` module for provisioning developer users.

In addition modules for provisioning other user types are moved inside the same namespace.

## v8.1.0 - 2018-04-20

* Make scale up and down period for an sqs_autoscaling_service be configurable
* Fix a bug in the way the cloudwatch metrics alarm are defined which caused them to scale down (or up) before the scaledown period had passed
* Make the ecs cluster use the submodules from the same release

## v8.0.3 - 2018-04-19

This release fixes a suspected bug in SQS autoscaling where both scale down and scale up alarms where triggered at the same time.

## v8.0.2 - 2018-04-16

This release removes the unused variable `use_task_definition_template_path`
introduced from the last release.

## v8.0.1 - 2018-04-12

This release adds `task_definition_template_path` to the `ecs_task` to allow
the use of a custom task definition file.

## v8.0.0 - 2018-03-07

This update allows you to specify multiple hosted zones within one hosted zone role.

## v7.0.1 - 2018-02-22

This release adds `min_capacity` and `max_capacity` to the `sqs_autoscaling_service` to allow to customise the minimum and maximum number of tasks per service.

## v6.4.1 - 2018-02-05

This release adds a `asg_security_group_ids` output on the ecs/cluster module. It is a list containing the list of security groups that instances in the cluster belong to

## v6.4.0 - 2018-01-22

This release exposes some new parameters on the _sqs_ module:

*   `visibility_timeout_seconds`
*   `message_retention_seconds`
*   `max_message_size`
*   `delay_seconds`
*   `receive_wait_time_seconds`

These are passed directly to parameters of the same name on [_aws_sqs_queue_](https://www.terraform.io/docs/providers/aws/r/sqs_queue.html#visibility_timeout_seconds).
Defaults are as before, so there should be no change to your queues until you override one of the parameters above.

## v6.3.0 - 2018-01-18

This adds a new module: _autoscaling/dynamodb_, which allows you to define auto scaling rules for DynamoDB tables.
See the [module README](autoscaling/dynamodb/README.md) for usage details.

## v6.2.0 - 2018-01-17

This adds a new parameter `enable_alb_alarm` to the *sqs_autoscaling_alarm* module.
It is passed through directly to the underlying *ecs/service* module.

It defaults to `true`; set it to `false` to disable ALB alarms in autoscaled services.

## v6.1.1 - 2018-01-15

This fixes a bug in the ALB alarms introduced in v6.1.0 for _ecs/service_.

We added a new ALB alarm for "not enough healthy hosts".  Previously it would
fire if the number of healthy hosts was _equal_ to the minimum allowed number
(minimum healthy percentage * desired count) -- even though this is normal
behaviour, e.g. when ECS is changing task definitions.

Now the alarm only fires if the number of hosts drops _below_ the minimum
allowed number.

## v6.1.0 - 2018-01-08

This adds two new CloudWatch alarms to the _ecs/service_ module:

*   One which alarms whenever the UnHealthyHostCount metric in the ALB target
    group is non-zero.

*   One which alarms whenever the HealthyHostCount metric in the ALB target
    group is less than the desired number of hosts.

These alarms are created if you pass `enable_alb_alarm = true` when creating
the instance of the module.

## v6.0.0 - 2018-01-08

Instances of the `ecs/service` module no longer ignore changes to the
`desired_count` parameter.  Practically speaking, that means you can edit the
parameter in Terraform and those changes will stick, rather than having to
adjust the desired count in a separate process.

## v5.3.0 - 2018-01-04

The `alb_priority` variable is now optional on _ecs/service_ and
_sqs_autoscaling_service_.  If you don't set an explicit ALB priority, a
priority will be randomly chosen and assigned.

This is useful if, for example, your services distinguish ALB routing targets
with non-overlapping path patterns.  One service replies to `/ingestor/`,
another to `/id_minter/`, another to `/transformer/` --- and so ALB priorities
are irrelevant for routing.

## v5.2.2 - 2017-12-21

This is a bugfix release.

There was a bug in the previous version of the _autoscaling/app/ecs_ module
that meant that autoscaling targets were continually deleted and recreated, and
getting a complete set of working targets was a bit of a "whack-a-mole"
process.

Autoscaling targets are now created consistently, and only once.

See [wellcometrust/terraform-modules #34](https://github.com/wellcometrust/terraform-modules/pull/34).

## v5.2.1 - 2017-12-19

This is a bugfix release.

Previously the _ecs/cluster_ module could throw an error if you tried
to create a cluster with a name containing an underscore (`_`).

The module creates an ALB target group with the same name, and underscores
aren't allowed in target group names.  Now it replaces underscores with hyphens
in the ALB target group name.

## v5.2.0 - 2017-12-18

This creates a new _ecs/cluster_ module for spinning up an ECS cluster with spot and on-demand instances, and auto-scaling rules for both.

The following modules have been renamed:

*   _ecs_asg_ is now _ecs/asg_
*   _ecs_alb_ is now _ecs/alb_
*   _service_ is now _ecs/service_

## v5.0.2 - 2017-12-15

This is a bugfix release.

This adds `create_before_destroy` to the autoscaling target in _autoscaling/app/ecs_.
This should fix some issues when creating `aws_appautoscaling_policy`.

## v5.0.1 - 2017-12-15

This fixes a bug in v5.0.0 where the _sqs_autoscaling_service_ module was pointing to a non-existent version of the _service_ module.
