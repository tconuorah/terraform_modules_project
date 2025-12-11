resource "aws_db_subnet_group" "this" {
name = "${var.name}-db-subnets"
subnet_ids = var.private_subnet_ids
tags = { Name = "${var.name}-db-subnets" }
}


resource "aws_security_group" "db_mysql" {
name = "${var.name}-db-mysql"
vpc_id = var.vpc_id


ingress {
from_port = 3306
to_port = 3306
protocol = "tcp"
security_groups = [var.ec2_mysql_id]
description = "Allow from EC2 mysql"
}


egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}


tags = { Name = "${var.name}-db-mysql" }
}


resource "aws_db_instance" "this" {
username = var.db_username
db_name = var.db_name
password = var.db_password
identifier        = "${var.name}-mysql"
engine            = "mysql"
engine_version    = "8.0"     # or a specific version like "8.0.39"
instance_class    = var.instance_class
allocated_storage = 20
port              = 3306
db_subnet_group_name = aws_db_subnet_group.this.name
vpc_security_group_ids = [aws_security_group.db_mysql.id]
skip_final_snapshot = true
publicly_accessible = false
deletion_protection = false
multi_az = false
storage_encrypted = true
backup_retention_period = 1
apply_immediately = true
auto_minor_version_upgrade = true
performance_insights_enabled = false
monitoring_interval = 0
tags = { Name = "${var.name}-mysql" }
}