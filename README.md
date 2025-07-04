# Terraform AWS EKS Cluster with a Simple App Deployment

This repository provides a complete Terraform setup to provision an Amazon EKS cluster and deploy a simple containerized service (NGINX) using Kubernetes.

---

## 🚀 Features

- Creates a VPC with subnets
- Provisions an EKS cluster and node group
- Deploys a sample app (NGINX) to the cluster
- Exposes the app via a LoadBalancer service
- Uses separate Terraform module for EKS infrastructure

---

## 📁 Project Structure

.
├── main.tf # Root module to deploy Kubernetes app
├── variables.tf
├── outputs.tf
└── modules/
└── eks/ # EKS provisioning module
├── main.tf
├── variables.tf
└── outputs.tf
---

## ⚙️ Requirements

- Terraform >= 1.4
- AWS CLI with credentials configured
- `kubectl` installed
- AWS IAM user/role with EKS + VPC + EC2 permissions

---

## 🛠️ Usage

Clone the repository and apply the Terraform configuration:

```bash
git clone https://github.com/your-username/terraform-eks-service.git
cd terraform-eks-service

terraform init
terraform apply

After a few minutes, you’ll see outputs including:

EKS cluster endpoint

Load balancer hostname (URL for the app)