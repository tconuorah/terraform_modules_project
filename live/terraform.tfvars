region               = "us-east-2"
az_count             = 2
instance_type        = "t3.micro"
key_name             = "kp"
allowed_ingress_cidr = "146.75.165.45/32" # local host public Ip address which makes it the only computer to remote access ec2 instance


# DB credentials (use environment variables or a secrets manager for real usage)
db_username = "appuser"
db_password = "pa$$word"
db_name     = "appdb"