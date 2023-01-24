# download providers and modules
terraform init

# provision AKS
terraform apply -target module.rg
terraform apply -target module.aks

# terraform apply