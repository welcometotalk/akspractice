AZ_AKS_CLUSTER_NAME=$(awk -F'"' '/cluster_name/{ print $2 }' terraform.tfvars)
export KUBECONFIG="$HOME/.kube/$AZ_AKS_CLUSTER_NAME.yaml"

kubectl port-forward --namespace "hello" service/demo 8080:80