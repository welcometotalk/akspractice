# resource group
resource_group_name = "learn-terraform"
location            = "eastus"
create_group        = true

# kubernetes cluster
cluster_name        = "akstest"
dns_prefix          = "basic"

# Service Bus

servicebus_name  = "akstest-serviebus-namespace"