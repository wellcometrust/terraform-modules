RELEASE_TYPE: minor

* Make scale up and down period for an sqs_autoscaling_service be configurable
* Fix a bug in the way the cloudwatch metrics alarm are defined which caused them to scale down (or up) before the scaledown period had passed
* Make the ecs cluster use the submodules from the same release