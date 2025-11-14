variable "name" { type = string }
variable "subnet_id" { type = string }
variable "vpc_id" {
  type = string
}
variable "instance_type" {
  type    = string
  default = "t3.medium"
}
variable "key_name" {
  type    = string
}
variable "allowed_ingress_cidr" {
  type        = string
  description = "CIDR allowed to SSH/HTTP to EC2"
}