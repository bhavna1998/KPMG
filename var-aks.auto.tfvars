aks_additional_tags = {}
aks = {
  aks-cus-app-dev-01 = {
    resource_group_name              = "rg-cus-app-dev-001"    #(Required) Name of resource group                          
    name                             = "aks-cus-app-dev-01"    #(Required) Name of Azure Kubernetes Cluster
    sku_tier                         = "Paid"                  #(Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free
    dns_prefix                       = "aks-cus-tryout-dev-01" #(Optional) DNS prefix specified when creating the managed cluster
    kubernetes_version               = "1.23.8"                #(Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)
    private_cluster_enabled          = true                    #(Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses?
    private_dns_zone_id              = null                    #(Optional) IDs of private DNS Zone
    local_account_disabled           = true                    #(Optional) If true local accounts will be disabled. Defaults to false
    azure_monitoring_enabled         = true                    #(Required) Enable or disable azure monitoring
    law_name                         = "law-cus-hub-dev-001"   #(Required if azure_monitoring is enabled) Name of the log analytics workspace for monitoring
    law_rg_name                      = "rg-cus-app-dev-001"    #(Required if azure_monitoring is enabled) Name of the resource group of log analytics workspace
    azure_policy_enabled             = true                    #(Optional) Enable or disable azure policy
    http_application_routing_enabled = false                   #(Optional) Enable or disable http application routing
    enable_secret_store_csi_driver   = true
    secret_store = {
      secret_rotation_enabled  = false #(Required if enable_secret_store_csi_driver=true) Enable or disable secret roation 
      secret_rotation_interval = "2m"  #(Required if enable_secret_store_csi_driver=true and secret rotation is enabled) The interval to poll for secret rotation. Defaults to "2m" 
    }
    network_plugin              = "azure"         #(Required) Network plugin to use for networking. Currently supported values are azure and kubenet
    network_policy              = "calico"        #(Optional) Sets up network policy to be used with Azure CNI. Currently supported values are calico and azure
    service_cidr                = "10.67.0.0/24"  #(Optional) The Network Range used by the Kubernetes service
    dns_service_ip              = "10.67.0.10"    #(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns)
    docker_bridge_cidr          = "172.17.0.1/16" #(Optional) IP address (in CIDR notation) used as the Docker bridge IP address on nodes
    load_balancer_sku           = "standard"
    outbound_type               = "userDefinedRouting" #(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer, userDefinedRouting, managedNATGateway and userAssignedNATGateway. Defaults to loadBalancer                                                                                                                                                 #(Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are basic and standard. Defaults to Standard
    automatic_channel_upgrade   = "patch"              #(Optional) The upgrade channel for this Kubernetes Cluster. Possible values are patch, rapid, node-image and stable. Defaults to none
    maintenance_window_enabled = true                 #(Required) Enable or disable maintenance windows
    maintenance_window = {
      day   = "Monday" #(Required) A day in a week. Possible values are Sunday, Monday, Tuesday, Wednesday, Thursday, Friday and Saturday
      hours = [9]      #(Required) An array of hour slots in a day. For example, specifying 1 will allow maintenance from 1:00am to 2:00am. Specifying 1, 2 will allow maintenance from 1:00am to 3:00m. Possible values are between 0 and 23
    }
    oidc_issuer_enabled              = "true"
    systempool_name                  = "agentpool"                                                                                                                                                 #(Required) The name which should be used for the default Kubernetes Node Pool
    systempool_availability_zones    = ["1", "2", "3"]                                                                                                                                             #(Optional) A list of Availability Zones across which the Node Pool should be spread
    systempool_type                  = "VirtualMachineScaleSets"                                                                                                                                   #(Optional) The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets
    systempool_node_count            = 1                                                                                                                                                           #(Optional) The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count
    systempool_vm_size               = "Standard_DS4_v2"                                                                                                                                           #(Required) The size of the Virtual Machine
    systempool_enable_auto_scaling   = true                                                                                                                                                        #(Optional) Should the Kubernetes Auto Scaler be enabled for this Node Pool? Defaults to false
    systempool_max_count             = 2                                                                                                                                                           #(Required when autoscaling is enabled) The maximum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000
    systempool_min_count             = 1                                                                                                                                                           #(Required when autoscaling is enabled) The minimum number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000
    systempool_os_disk_type          = "Ephemeral"                                                                                                                                                 #(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed
    systempool_os_disk_size_gb       = 128                                                                                                                                                         #(Optional) The size of the OS Disk which should be used for each agent in the Node Pool
    systempool_max_pods              = 30                                                                                                                                                          #(Optional) The maximum number of pods that can run on each agent
    systempool_enable_node_public_ip = false                                                                                                                                                       #(Optional) Should nodes in this Node Pool have a Public IP Address? Defaults to false
    systempool_node_subnet_name      = "sn-cus-sharedservices-dev"                                                                                                                                 #(Required) Name of the subnet
    systempool_node_vnet_name        = "vnet-cus-hub-dev-001"                                                                                                                                      #(Required) Name of the virtual network in which subnet is created
    systempool_node_vnet_rg_name     = "rg-cus-app-dev-001"                                                                                                                                        #(Required) Name of the resource group of virtual network
    systempool_pod_subnet_name       = "sn-cus-sharedservices-dev"                                                                                                                                 #(Required) Name of the subnet in which systempool pods are to be created
    systempool_pod_vnet_name         = "vnet-cus-hub-dev-001"                                                                                                                                      #(Required) Name of the vnet of the subnet in which systempool pods are to be created
    systempool_pod_vnet_rg_name      = "rg-cus-app-dev-001"                                                                                                                                        #(Required) Name of the resource group of the subnet in whihc systempool pods are to be created
    only_critical_addons_enabled     = true                                                                                                                                                        #(Optional) Enabling this option will taint default node pool with CriticalAddonsOnly=true:NoSchedule taint
    rbac_enabled                     = true                                                                                                                                                        #(Optional) - Whether Role Based Access Control for the Kubernetes Cluster should be enabled. Defaults to true
    identity_type                    = "UserAssigned"                                                                                                                                              #(Required) Specifies the type of Managed Service Identity that should be configured on this Kubernetes Cluster. Possible values are "SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"
    identity_ids                     = ["/subscriptions/13b84f64-d1ad-43ba-b2fa-d7c91c8d6506/resourceGroups/rg-cus-app-dev-001/providers/Microsoft.ManagedIdentity/userAssignedIdentities/aks-id"] #(Required when identity_type is set to "UserAssigned" or "SystemAssigned, UserAssigned") Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster
    aad_enabled                      = true
    aad = {
      aad_managed            = true                                                                             #(Optional) Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration
      admin_group_object_ids = ["4aa3cb0c-bb17-4f9c-9735-247d21fb8e2e", "af81e0d9-000f-4866-a685-5e2aaeff19e0"] #(Required when aad_managed is set to true) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster
      aad_rbac_enabled       = true                                                                             #(Optional) Is Role Based Access Control based on Azure AD enabled
      client_app_id          = null                                                                             #(Required when aad_managed is set to false) The Client ID of an Azure Active Directory Application
      server_app_id          = null                                                                             #(Required when aad_managed is set to false) The Server ID of an Azure Active Directory Application
      server_app_secret      = null                                                                             #(Required when aad_managed is set to false) The Server Secret of an Azure Active Directory Application
    }
    http_proxy                     = ""                          #(Optional) The proxy address to be used when communicating over HTTP
    https_proxy                    = ""                          #(Optional) The proxy address to be used when communicating over HTTPS
    no_proxy                       = ["10.0.0.0/24"]             #(Optional) The list of domains that will not use the proxy for communication
    cmk_enabled                    = true                        #(Required) Enable or disable customer managed keys
    disk_encryption_set_name       = "des-cus-app-dev-001"       #(Required if cmk enabled) Name of disk encryption set
    disk_encryption_rg_name        = "rg-cus-app-dev-001"        #(Required if cmk enabled) Name of resource group of disk encryption set
    acr_id                         = ""                          #(Required) Value of ACR to be integrated
  }
}
aks_userpool = {
  userpool = {
    name                           = "userpool"                  #(Required) Name of user nodepool
    aks_name                       = "aks-cus-app-dev-01"        #(Required) Name of AKS cluster
    userpool_availability_zones    = ["1", "2", "3"]             #(Optional) A list of Availability Zones across which the Node Pool should be spread
    userpool_os_disk_size_gb       = 128                         #(Optional) The size of the OS Disk which should be used for each agent in the User Node Pool
    userpool_os_disk_type          = "Ephemeral"                 #(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed
    userpool_node_count            = 1                           #(Optional) The initial number of nodes which should exist in this Node Pool. If specified this must be between 1 and 1000 and between min_count and max_count
    userpool_vm_size               = "Standard_DS4_v2"           #(Required) The size of the Virtual Machine
    userpool_enable_auto_scaling   = true                        #(Optional) Whether to enable auto-scaler. Defaults to false
    userpool_max_count             = 3                           #(Required) The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count
    userpool_min_count             = 1                           #(Required) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count
    userpool_os_type               = "Linux"                     # (Optional) The Operating System which should be used for this Node Pool. Changing this forces a new resource to be created. Possible values are Linux and Windows. Defaults to Linux
    userpool_max_pods              = 30                          #(Optional) The maximum number of pods that can run on each agent
    userpool_enable_node_public_ip = false                       #(Optional) Should each node have a Public IP Address? Defaults to false
    nodepool_node_subnet_name      = "sn-cus-sharedservices-dev" #(Required) Name of the subnet in which userpool nodes are to be created
    nodepool_node_vnet_name        = "vnet-cus-hub-dev-001"      #(Required) Name of the virtual network in which subnet is created
    nodepool_node_vnet_rg_name     = "rg-cus-app-dev-001"        #(Required) Name of the resource group of virtual network
    nodepool_pod_subnet_name       = "sn-cus-sharedservices-dev" #(Required) Name of the subnet in which systempool pods are to be created
    nodepool_pod_vnet_name         = "vnet-cus-hub-dev-001"      #(Required) Name of the vnet of the subnet in which systempool pods are to be created
    nodepool_pod_vnet_rg_name      = "rg-cus-app-dev-001"        #(Required) Name of the resource group of the subnet in whihc systempool pods are to be created
  }
}