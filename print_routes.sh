AZ_RESOURCE_GROUP=$(terraform output -raw resource_group_name)
AZ_LOCATION=$(awk -F'"' '/location/{ print $2 }' terraform.tfvars)
AZ_AKS_CLUSTER_NAME=$(terraform output -raw kubernetes_cluster_name)

az network route-table list \
  --resource-group MC_${AZ_RESOURCE_GROUP}_${AZ_AKS_CLUSTER_NAME}_${AZ_LOCATION} \
  --query '[].routes[].{Name:name,"Address Prefix":addressPrefix,"Next hop IP address":nextHopIpAddress}' \
  --output table