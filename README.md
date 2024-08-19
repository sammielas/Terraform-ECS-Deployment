# Rentzone Application on AWS with Terraform, Docker, Amazon ECR, and ECS

This README file provides detailed instructions on how to deploy a rentzone app which is a dynamic web application on Amazon Web Services (AWS) using Terraform, Docker, Amazon Elastic Container Registry (ECR), and Elastic Container Service (ECS). The steps outlined below will guide you through the entire process, from setting up your AWS environment to deploying your application using Terraform.

## Prerequisites

- AWS Account
- AWS CLI installed on your local machine
- Terraform installed on your local machine
- Docker installed on your local machine
- Git installed on your local machine

## Steps

### 1. Create an IAM User on AWS

1. Log in to the AWS Management Console.
2. Navigate to **IAM (Identity and Access Management)**.
3. Create a new IAM user with `Programmatic access` and assign the required permissions (e.g., `AdministratorAccess` for development purposes).

### 2. Generate an Access Key for the IAM User

1. After creating the IAM user, generate an access key.
2. Save the Access Key ID and Secret Access Key securely as you'll need them to configure the AWS CLI.

### 3. Create a Named Profile for the IAM User

1. Open your terminal.
2. Run the following command to configure your AWS credentials:
   ```bash
   aws configure --profile <profile-name>
   ```
3. Enter the Access Key ID, Secret Access Key, default region, and output format when prompted.

### 4. Store Terraform State with S3 Bucket

1. Create an S3 bucket on AWS to store your Terraform state file.
2. Enable versioning on the bucket to maintain the history of your state files.

### 5. Create a DynamoDB Table to Lock Terraform State

1. Navigate to **DynamoDB** in the AWS Management Console.
2. Create a new table to be used for state locking. Set `LockID` as the primary key.

### 6. Create and Clone a Git Repository for Storing Terraform Modules

1. If you don't already have a repository for your Terraform modules, create one.
2. Clone the repository to your local machine:
   ```bash
   git clone <repository-url>
   ```

### 7. Create Terraform Module for VPC

1. Inside the cloned repository, create a directory for your VPC module.
2. Define the necessary Terraform configurations for creating a VPC with public and private subnets.

### 8. Create Another Repository for the Project Application

1. Create a separate repository for your application that will be deployed on AWS.
2. Clone the repository to your local machine:
   ```bash
   git clone <repository-url>
   ```

### 9. Configure AWS Provider in Terraform

1. In your Terraform project, configure the AWS provider to establish a connection between Terraform and AWS:
   ```hcl
   provider "aws" {
     region  = "<region>"
     profile = "<profile-name>"
   }
   ```

### 10. Create a Terraform Backend

1. Configure Terraform to use the S3 bucket for state storage and DynamoDB for state locking:
   ```hcl
   terraform {
     backend "s3" {
       bucket         = "<s3-bucket-name>"
       key            = "terraform.tfstate"
       region         = "<region>"
       dynamodb_table = "<dynamodb-table-name>"
     }
   }
   ```

### 11. Create a VPC with Public and Private Subnets

1. Use the VPC module to create a VPC with public and private subnets across two different availability zones (AZs).

### 12. Create a NAT Gateway

1. In the public subnet, create a NAT gateway to allow instances in the private subnet to access the internet.

### 13. Create Security Groups

1. Define the necessary security groups for your application, database, and other AWS resources.

### 14. Create an RDS Database

1. Use Terraform to create a new RDS instance or restore one from a previous snapshot.

### 15. Request ACM Certificates

1. Use Terraform to request an ACM (AWS Certificate Manager) SSL certificate for your domain.

### 16. Set Up SSL Certificates

1. Attach the SSL certificates to the appropriate AWS resources, such as the Application Load Balancer (ALB).

### 17. Create an Application Load Balancer

1. Use Terraform to create an Application Load Balancer and associate it with your subnets.

### 18. Create an S3 Bucket for the Application

1. Create an S3 bucket to store any assets or files needed by your application.

### 19. Create Task Execution Role for ECS Service

1. Define a task execution role in IAM that the ECS service can assume to pull images and execute tasks.

### 20. Create Terraform Module for ECS Cluster, Task Definition, and Service

1. Create and configure Terraform modules for your ECS Cluster, Task Definition, and Service.

### 21. Create Auto Scaling Group and Connect to ECS Service

1. Set up an Auto Scaling group to ensure your ECS tasks scale based on demand.

### 22. Create a Route 53 DNS Record for Your Application

1. Create a Route 53 DNS record to point to your Application Load Balancer.

## Conclusion

Following these steps, you will have successfully deployed a dynamic web application on AWS using Terraform, Docker, Amazon ECR, and ECS. You can manage and scale your infrastructure as code, ensuring a consistent and repeatable deployment process.
