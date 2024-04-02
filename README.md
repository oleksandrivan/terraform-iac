# terraform-iac

The terraform-iac project is a Terraform-based Infrastructure as Code (IaC) setup. It uses Google Cloud's gcloud for authentication and Terraform for initializing, planning, and applying infrastructure changes.

The project also includes a setup for a master-worker connection using microk8s, a lightweight Kubernetes distribution. It involves adding the current user to the microk8s group and creating a new group session.

Additionally, it uses kubectl to create a secret named regcred from a Docker configuration file. This secret can be used to pull images from a private Docker registry.

Please note that the actual functionality might vary based on the Terraform scripts and Kubernetes configurations not visible in the provided excerpt.

## Deploy 

Deploys 2 Spot VMs and provisions neccesary software.

```bash
gcloud auth application-default login
terraform init
terraform plan
terraform apply
```

## Master-worker connection

How to connect worker to control node.

```bash
sudo vim /var/snap/microk8s/current/certs/csr.conf.template # Add public IP entry
microk8s add-node # On master node and copy command
microk8s join XXX # Run previous command on worker
```

## Creating k8s secret for pulling containers from private registry

Generate KEY-FILE in the private registry in GCloud for pulling containers.

```bash 
cat KEY-FILE | docker login -u _json_key --password-stdin https://us-central1-docker.pkg.dev 
kubectl create secret generic regcred \
    --from-file=.dockerconfigjson=~/.docker/config.json \
    --type=kubernetes.io/dockerconfigjson
```

## Deploying monitoring and CI stack in Kubernetes

Deploys Prometheus + Grafana and ArgoCD on cluster.

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm install prometheus prometheus-community/kube-prometheus-stack
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/core-install.yaml
```
