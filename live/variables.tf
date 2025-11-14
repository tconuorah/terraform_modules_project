variable "region" {
  type    = string
}
variable "az_count" {
  type    = number
}
variable "instance_type" {
  type    = string
}
variable "key_name" {
  type        = string
  description = "Existing EC2 key pair name"
}
variable "allowed_ingress_cidr" {
  type        = string
  description = "CIDR allowed to reach EC2 (SSH/HTTP)"
}
variable "db_username" {
  type = string
}
variable "db_password" {
  type      = string
  sensitive = true
}
variable "db_name" {
  type    = string
}