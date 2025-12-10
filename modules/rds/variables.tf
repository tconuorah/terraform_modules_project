variable "name" { 
    type = string
    default = "db_server" 
    }
variable "vpc_id" { type = string }
variable "private_subnet_ids" { type = list(string) }
variable "db_username" { type = string }
variable "db_password" {
  type      = string
  sensitive = true
}
variable "db_name" {
  type    = string
  default = "appdb"
}
variable "ec2_mysql_id" {
  type        = string
  description = "EC2 security group permitted to reach DB"
}
variable "instance_class" {
  type    = string
  default = "db.t4g.medium"
}