RELEASE_TYPE: minor

*   When using `ecs/modules/security_groups`, skip creating a security group
    to grant SSH access to instances if there aren't any CIDR blocks or
    security groups that the ingress rule applies to.

*   New module: `network/prebuilt/vpc/egress_security_group`, which
    creates a security group that allows all egress traffic and sets up
    VPC interface endpoints.

*   New module: `network/prebuilt/vpc/interface_endpoints`, which creates
    some common VPC interface endpoints.

*   The `network/prebuilt/vpc/public-private-igw` module automatically created
    VPC gateway endpoints for S3 and DynamoDB.
