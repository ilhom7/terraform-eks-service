# Terraform EKS Deployment with NGINX App

This repository provides a complete Terraform setup to provision an Amazon EKS cluster and deploy a simple containerized service (NGINX) using Kubernetes.

---

## What's Included

- VPC, subnets, NAT gateway, and networking (via module)
- IAM roles and policies for EKS control plane and node group
- EKS cluster with managed node group
- Kubernetes namespace, deployment, and service (NGINX)
- Internal access using port-forwarding (ClusterIP service)

---

## Project Structure

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

## Prerequisites

- Terraform >= 1.4
- AWS CLI configured with appropriate IAM permissions
- `kubectl` installed and configured
- SSH access to an EC2 instance

---

## Usage

Clone the repository and apply the Terraform configuration:

```bash
git clone https://github.com/ilhom7/terraform-eks-service.git
cd terraform-eks-service

terraform init
terraform apply


This provisions:

VPC

EKS control plane

Node group

IAM roles
Accessing the App
By default, the app is exposed via a ClusterIP service (internal only).

🛠 SSH Port Forwarding (from local machine)
1. On your Windows PC:
Open PowerShell or CMD:

powershell
Copy
Edit
ssh -i "C:\Path\To\your-key.pem" -L 8888:localhost:8888 ubuntu@<EC2-Public-IP>
Replace with the path to your .pem file and your EC2 public IP.

2. On the EC2 instance:
bash
Copy
Edit
kubectl port-forward svc/myapp-service -n myapp 8888:80
3. In your browser (on Windows):
Open: http://localhost:8888

✅ You should see the NGINX welcome page.