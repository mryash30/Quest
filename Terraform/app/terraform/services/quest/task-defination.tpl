[
	{
		"name": "${container_name}",
		"hostname": "${container_name}",
		"image": "${image_name}",
		"cpu": ${container_cpu},
		"memoryReservation": ${container_memory},
		"essential": true,
		"dockerLabels": {
			"Name": "${container_name}"
		},
		"portMappings": [
			{
				"hostPort": 0,
				"protocol": "tcp",
				"containerPort": ${container_port}
			}
		],
		"mountPoints": [
			{
				"readOnly": null,
				"containerPath": "${mount_path}",
				"sourceVolume": "${mount_volume}"
			},
			{
            "readOnly": null,
            "containerPath": "${container_nginx_log_path}",
            "sourceVolume": "${host_nginx_log}"
            }
		],
		"logConfiguration": {
                    "logDriver": "awslogs",
                    "options": {
                        "awslogs-create-group": "true",
                        "awslogs-region" : "${region}",
                        "awslogs-group" : "/ecs/${project_name}-${env}-${application_name}-service",
                        "awslogs-stream-prefix" : "ecs"
                    }
        },
		"environment": [],
		"links": null,
		"dependsOn": null,
		"disableNetworking": false
	}
]
