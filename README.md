# Build Python API application on AWS EKS cluster 

## Prerequisites

### Install needed tools:

kubectl: https://kubernetes.io/docs/tasks/tools/

AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

Terraform: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

minikube: https://minikube.sigs.k8s.io/docs/start/

Docker: https://docs.docker.com/engine/install/

### Create Remote backend S3 bucket 

Bucket name: python-api-terraform

### Create Helm repo for helm packages

- Bucket name: python-api-helm

- Init the repo: `helm s3 init s3://python-api-helm`

## Provision the infrastructure

```
cd terraform

terraform init

terraform apply
```

### Connect to K8s cluster after provisioning:

`aws eks --region us-east-2 update-kubeconfig --name dev`


## Update Github secrets

Update Github secrets with IAM access `AWS_ACCESS_KEY_ID` and secret key `AWS_SECRET_ACCESS_KEY` created from the terraform

## local environment

We will use Docker Compose for local development

To start your containers:

`docker compose up -d --build`

Use `localhost:8000` to connect to your app.