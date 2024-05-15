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

## Update Github secrets

Update Github secrets with IAM access `AWS_ACCESS_KEY_ID` and secret key `AWS_SECRET_ACCESS_KEY` created from the terraform

### Connect to K8s cluster after provisioning:

`aws eks --region us-east-2 update-kubeconfig --name dev`

### Deploy Gatekeeper for open-policy-agent:

```
helm repo add gatekeeper https://open-policy-agent.github.io/gatekeeper/charts --force-update

helm install external-secrets \
  external-secrets/external-secrets \
    --namespace external-secrets \
    --create-namespace \
    --set installCRDs=true
kubectl -n gatekeeper-system get all
```

Associate an existing OIDC provider with your EKS cluster

### Deploy External Secrets Operator:

#### Install the operator

```
helm repo add external-secrets https://charts.external-secrets.io

helm install external-secrets \
  external-secrets/external-secrets \
    --namespace external-secrets \
    --create-namespace \
    --set installCRDs=true
```

#### Associate an existing OIDC provider with your EKS cluster

`eksctl utils associate-iam-oidc-provider --cluster=dev --approve`

#### IAM Role trust policy

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::{account-id}:oidc-provider/{OIDC-URL}"
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "{OIDC-URL}:sub": "system:serviceaccount:{namespace}:{service-account-name}"
                }
            }
        }
    ]
}
```

#### IAM Policy

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "secretsmanager:GetSecretValue",
                "secretsmanager:ListSecretVersionIds"
            ],
            "Resource": "arn:aws:secretsmanager:{region}:{account-id}:secret:*",
            "Effect": "Allow"
        }
    ]
}
```

####  Create a Service Account

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: external-secrets
  namespace: external-secrets
  annotations:
    eks.amazonaws.com/role-arn: {iam-role-arn}
```

#### Create a SecretStore

```
apiVersion: external-secrets.io/v1beta1
kind: ClusterSecretStore
metadata:
  name: aws-secrets-manager
  namespace: external-secrets
spec:
  provider:
    aws:
      service: SecretsManager
      region: {region}
      auth:
        jwt:
          serviceAccountRef:
            name: external-secrets
            namespace: external-secrets
```

Add your secret to AWS Secret manager.

## Dev environment

Use port-forward to connect to the svc

`kubectl port-forward svc/python-api 8000:8000 -n dev`

## local environment

We will use Docker Compose for local development

To start your containers:

`docker compose up -d --build`

Use `localhost:8000` to connect to your app.


## TODO

- Add OPA policy to prevent root users and default SA for deployments
- Add Nginx ingress
- Add Cert-manager for https certificate
- Use Ingress certificate for https connection to the Service.
- Use DNS domain and add A record for Ingress IP