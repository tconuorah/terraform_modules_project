# Terraform Modules Project – VPC, EC2, and RDS with Remote State Management

## Overview

This project demonstrates how to build a **production-ready AWS infrastructure** using **Terraform modules**. The infrastructure includes a **VPC**, **EC2 instance**, and **RDS database**, with **remote state management** handled through **Amazon S3** (for state storage) and **DynamoDB** (for state locking).

The setup follows best practices for scalability, security, and maintainability, making it easy to manage multiple environments such as **staging** and **production**.

---

## Objectives

* Create a modular Terraform setup that provisions:

  * **AWS VPC** (public and private subnets)
  * **EC2 instance** (deployed in a public subnet)
  * **RDS instance** (deployed in private subnets)
* Implement **S3 backend** for Terraform state storage
* Enable **DynamoDB table locking** to prevent concurrent state changes
* Support **multiple environments** (staging, production) using Terraform workspaces

---

## Project Structure

```
terraform-modules-exercise/
├── bootstrap/                 # One-time setup for S3 and DynamoDB backend
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── README.md
│
├── modules/                   # Reusable Terraform modules
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── rds/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
└── live/                      # Environment configurations (staging, prod, etc.)
    ├── provider.tf
    ├── main.tf
    ├── variables.tf
    ├── outputs.tf
    └── backend.tf
```

---

## Setup Instructions

### 1. Configure the Backend

In the `bootstrap` directory, create the S3 bucket and DynamoDB table to manage remote state and locking:

* **S3** – for versioned and encrypted Terraform state files
* **DynamoDB** – for state locking and concurrency control

After setting up, confirm versioning and encryption are enabled.

---

### 2. Initialize Terraform Backend

In the `live` directory, create a `provider.tf` that references the backend configuration from `bootstrap/main.tf`.

Then run:

```bash
terraform init
```

This initializes:

* S3 backend
* Provider plugins
* Previously created modules

---

### 3. Plan and Apply Infrastructure

Run:

```bash
terraform plan
terraform apply
```

Verify all resources (VPC, EC2, and RDS) have been successfully deployed in the AWS Management Console.

---

### 4. Configure Workspaces for Environments

Use Terraform workspaces to manage different environments:

#### Staging:

```bash
terraform workspace new staging || true
terraform apply
```

#### Production:

```bash
terraform workspace new prod || true
terraform apply
```

This isolates configuration and state between environments while reusing the same modular codebase.

---

## Key Features

* **Reusable Modules:** Each resource (VPC, EC2, RDS) is independently defined and reusable.
* **Remote State Management:** Ensures consistent collaboration and state protection using S3 and DynamoDB.
* **Environment Isolation:** Terraform workspaces provide clear separation between staging and production.
* **Scalable Design:** Follows AWS best practices with public/private subnets and secure access control.

---

## Verification

After applying the configurations, verify the following in the AWS Management Console:

* **VPC:** Subnets, route tables, NAT gateway, and internet gateway are properly configured.
* **EC2:** Instance is running in the correct subnet and associated security group.
* **RDS:** Database instance is available and isolated within private subnets.
* **S3 & DynamoDB:** Backend resources are storing and locking state as expected.

---

## Cleanup

To destroy the infrastructure and avoid charges:

```bash
terraform destroy
```

If you encounter dependency issues, ensure dependent resources (like NAT gateways or RDS instances) are deleted before the VPC.

---

## Author

**Terrence Onuorah**
AWS | Terraform | DevOps | Cloud Infrastructure Engineer

