variable "region" {
  description = "AWS region where resources will be created"
  type        = string
  default     = "us-east-2"
}

variable "bucket_name" {
  description = "Name of the S3 bucket used for remote Terraform state"
  type        = string
  default = "tf-state-bucket"
}

variable "dynamodb_table" {
  description = "Name of the DynamoDB table used for state locking"
  type        = string
  default = "to-tf-locks"
}
