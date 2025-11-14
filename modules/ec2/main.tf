data "aws_ami" "al2023" {
most_recent = true
owners = ["137112412989"] # Amazon
filter {
name = "name"
values = ["al2023-ami-*-x86_64"]
}
}


resource "aws_security_group" "ec2_sg" {
name = "${var.name}-ec2-sg"
description = "Allow SSH & HTTP from allowed CIDR"
vpc_id = var.vpc_id


ingress {
description = "SSH"
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = [var.allowed_ingress_cidr]
}


ingress {
description = "HTTP"
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = [var.allowed_ingress_cidr]
}


egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}


tags = { Name = "${var.name}-ec2-sg" }
}


resource "aws_instance" "this" {
ami = data.aws_ami.al2023.id
instance_type = var.instance_type
subnet_id = var.subnet_id
vpc_security_group_ids = [aws_security_group.ec2_sg.id]
key_name = var.key_name
associate_public_ip_address = true


user_data = <<-EOF
#!/bin/bash
dnf update -y
dnf install -y httpd
systemctl enable --now httpd
echo "<h1>${var.name} – $(hostname)</h1>" > /var/www/html/index.html
EOF


tags = { Name = "${var.name}-ec2" }
}