client_name                         = "example"
primary_location                    = "uks"
secondary_location                  = "ukw"
dns_resource_group_name             = "rgp-weu-moulder-nonprod-dns"
is_production                       = true
is_premium                          = false
deploy_redis                        = true
subscription_id                     = "<AZURE_SUBSCRIPTION>"
dns_subscription                    = "<AZURE_DNS_SUBSCRIPTION>"
parent_zone                         = "moulder.io"
node_minimum_count                  = 3
node_maximum_count                  = 6

location_1                          = "UK South"
nodepool_vm_size_1                  = "Standard_E2s_v3"

location_2                          = "UKS West"
nodepool_vm_size_2                  = "Standard_E2s_v3"

tags = {
      Delete                 = "No"
      Expiration             = "Never"
      Area                   = "prod"
      Owner                  = "SRE"
      Project                = "Email"
      Publicly_Accessible    = "No"
      Purpose                = "Email"
  }