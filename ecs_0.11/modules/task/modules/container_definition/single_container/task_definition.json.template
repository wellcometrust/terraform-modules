[
  {
    "cpu": ${cpu},
    "memory": ${memory},
    "essential": true,
    "image": "${container_image}",
    "name": "${container_name}",
    "environment": ${environment_vars},
    "secrets": ${secrets},
    "networkMode": "awsvpc",
    "portMappings": ${port_mappings},
    "command": ${command},
    "logConfiguration": {
        "logDriver": "awslogs",
        "options": {
            "awslogs-group": "${log_group_name}",
            "awslogs-region": "${log_group_region}",
            "awslogs-stream-prefix": "${log_group_prefix}"
        }
    },
    "user": "${user}",
    "mountPoints": ${mount_points}
  }
]