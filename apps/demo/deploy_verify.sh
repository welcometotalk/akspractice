# change directory to the demo application

terraform init
terraform apply


# verify results
AZ_AKS_CLUSTER_NAME=$(awk -F'"' '/cluster_name/{ print $2 }' terraform.tfvars)
export KUBECONFIG="$HOME/.kube/$AZ_AKS_CLUSTER_NAME.yaml"

kubectl get all --namespace "hello"