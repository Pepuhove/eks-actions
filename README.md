# EKS Automated Deployment Pipeline

A complete CI/CD pipeline for building, scanning, and deploying a finance application to Amazon EKS using GitHub Actions.

## 📋 Project Overview

This project automates the deployment of a web application to Amazon EKS with:
- **SonarQube** code quality scanning
- **Docker** image building and pushing to ECR
- **Trivy** security vulnerability scanning
- **Helm** deployment to EKS cluster
- Full security and quality checks

## 🏗️ Architecture
GitHub Push → SonarQube Scan → Docker Build → ECR Push → Trivy Scan → EKS Deployment

text

## 📁 Project Structure
.
├── Dockerfile # Docker container definition
├── helm/ # Helm charts
│ ├── appcharts/
│ │ ├── Chart.yaml # Helm chart metadata
│ │ └── templates/
│ │ └── kubernetes/
│ │ ├── deployment.yaml
│ │ ├── ingress.yaml
│ │ └── service.yaml
│ ├── charts/
│ └── values.yaml
├── kubernetes/ # Direct Kubernetes manifests
│ ├── deployment.yaml
│ ├── ingress.yaml
│ └── service.yaml
├── src/ # Frontend application source
│ ├── css/
│ ├── fonts/
│ ├── images/
│ ├── js/
│ └── *.html
└── .github/workflows/ # GitHub Actions workflows

text

## 🚀 Getting Started

### Prerequisites

- AWS Account with EKS cluster configured
- ECR repository created
- SonarQube server (optional)
- Kubernetes cluster access

### Environment Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/Pepuhove/eks-actions.git
   cd eks-actions
Configure AWS Credentials

Create IAM user with EKS, ECR permissions

Add secrets to GitHub repository:

AWS_ACCESS_KEY_ID

AWS_SECRET_ACCESS_KEY

AWS_REGION

EKS_CLUSTER

ECR_REPOSITORY

REGISTRY

Optional: SonarQube Setup

Add SonarQube secrets if using code quality scanning:

SONAR_TOKEN

SONAR_HOST_URL

Manual Deployment
bash
# Build Docker image
docker build -t your-registry/finance-app:latest .

# Push to ECR
aws ecr get-login-password --region your-region | docker login --username AWS --password-stdin your-account-id.dkr.ecr.your-region.amazonaws.com
docker push your-registry/finance-app:latest

# Deploy to EKS
kubectl apply -f kubernetes/deployment.yaml
kubectl apply -f kubernetes/service.yaml
⚙️ GitHub Actions Workflow
The pipeline consists of three main jobs:

1. SonarQube Scanner
Static code analysis

Quality gate checking

Code security scanning

2. Build and Push
Docker image building

ECR repository push

Multi-tag support (latest, run-number)

3. Trivy Security Scan
Container vulnerability scanning

SARIF report generation

Security compliance checking

4. EKS Deployment
Helm-based deployment

Automatic rollback on failure

ECR authentication setup

Comprehensive status reporting

🔧 Configuration
Environment Variables
Variable	Description	Example
AWS_REGION	AWS region	us-east-1
EKS_CLUSTER	EKS cluster name	my-eks-cluster
ECR_REPOSITORY	ECR repository name	finance-app
REGISTRY	ECR registry URL	123456789012.dkr.ecr.us-east-1.amazonaws.com
Helm Values
The deployment uses these configurable values:

appimage: ECR image repository

apptag: Docker image tag (GitHub run number)

replicaCount: Number of pods (default: 2)

service.type: Kubernetes service type (ClusterIP)

service.port: Service port (80)

ingress.enabled: Ingress controller toggle

🛡️ Security Features
Trivy Vulnerability Scanning: Container security scanning

ECR Image Scanning: AWS native security scanning

IAM Role Best Practices: Least privilege access

Secret Management: GitHub encrypted secrets

Network Policies: Secure pod communication

📊 Monitoring
The deployment includes status checks for:

Pod health and readiness

Service endpoints

Ingress configuration

Resource utilization

💡 Usage Examples
Trigger Deployment Manually
bash
# Push to main branch to trigger automated deployment
git push origin main
Check Deployment Status
bash
kubectl get pods -n default
kubectl get services
kubectl get ingress
View Logs
bash
kubectl logs -l app=mini-finance
🚨 Troubleshooting
Common Issues
EKS Access Denied

Verify IAM permissions

Check kubectl configuration

ECR Authentication Failed

Verify ECR repository exists

Check IAM ECR permissions

Helm Deployment Failed

Check ingress controller installation

Verify values.yaml configuration

Debug Commands
bash
# Check EKS cluster status
aws eks describe-cluster --name your-cluster-name

# Verify ECR repository
aws ecr describe-repositories

# Check Kubernetes nodes
kubectl get nodes

# View detailed pod information
kubectl describe pod pod-name
📈 Cost Optimization
Uses t3.micro instances for development

Automatic scaling configuration

Resource limits and requests

Cleanup policies for old images

🤝 Contributing
Fork the repository

Create feature branch (git checkout -b feature/amazing-feature)

Commit changes (git commit -m 'Add amazing feature')

Push to branch (git push origin feature/amazing-feature)

Open a Pull Request

📝 License
This project is licensed under the MIT License - see the LICENSE file for details.

🙋‍♂️ Support
For support and questions:

Open an issue on GitHub

Check troubleshooting section

Review AWS EKS documentation
