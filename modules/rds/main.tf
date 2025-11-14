resource "aws_db_subnet_group" "this" {
name = "${var.name}-db-subnets"
subnet_ids = var.private_subnet_ids
tags = { Name = "${var.name}-db-subnets" }
}


resource "aws_security_group" "db_sg" {
name = "${var.name}-db-sg"
vpc_id = var.vpc_id


ingress {
from_port = 5432
to_port = 5432
protocol = "tcp"
security_groups = [var.ec2_sg_id]
description = "Allow PostgreSQL from EC2 SG"
}


egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}


tags = { Name = "${var.name}-db-sg" }
}


resource "aws_db_instance" "this" {
identifier = "${var.name}-pg"
engine = "postgres"
engine_version = "16"
instance_class = var.instance_class
allocated_storage = 20
db_name = var.db_name
username = var.db_username
password = var.db_password
db_subnet_group_name = aws_db_subnet_group.this.name
vpc_security_group_ids = [aws_security_group.db_sg.id]
skip_final_snapshot = true
publicly_accessible = false
deletion_protection = false
multi_az = false
storage_encrypted = true
backup_retention_period = 1
apply_immediately = true
auto_minor_version_upgrade = true
performance_insights_enabled = true
monitoring_interval = 0
tags = { Name = "${var.name}-pg" }
}