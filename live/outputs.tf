output "ec2_public_ip" { value = module.web_ec2.public_ip }
output "ec2_public_dns" { value = module.web_ec2.public_dns }
output "rds_endpoint" { value = module.db.endpoint }
output "rds_port" { value = module.db.port }
output "vpc_id" { value = module.network.vpc_id }