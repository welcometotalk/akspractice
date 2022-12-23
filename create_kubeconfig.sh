AZ_RESOURCE_GROUP="$(terraform output -raw resource_group_name)"
AZ_AKS_CLUSTER_NAME="$(terraform output -raw kubernetes_cluster_name)"
export KUBECONFIG="$HOME/.kube/$AZ_AKS_CLUSTER_NAME.yaml"

az aks get-credentials \
  --resource-group ${AZ_RESOURCE_GROUP} \
  --name ${AZ_AKS_CLUSTER_NAME} \
  --file ${KUBECONFIG}