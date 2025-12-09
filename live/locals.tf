locals {
  env         = terraform.workspace
  name_prefix = "${local.env}" # e.g., staging, prod


  # Per-env VPC CIDR examples (adjust as needed)
  vpc_cidrs = {
    staging = "10.10.0.0/16"
    prod    = "10.20.0.0/16"
  }


  vpc_cidr = lookup(local.vpc_cidrs, local.env, "10.50.0.0/16")
}