## NOTE: Read all given instructions before updating the values to get the resources created in first run.
## NOTE: example/main.tf to be used for deployment of resources through Gitlab.

module "windowsvmss" {
  source = "git::https://dev.azure.com/dmangeshtambe0819/_git/iac-azure-modules?path=/windowsvmss?ref=main"
  vmss = {
    vmss1 = {
      name                            = "vmss-cus-app-dev-web" #(Required) Name of windows virtual machine scale set
      resource_group_name             = "iac-poc-rg-001"       #(Required) Name of resource group in which vmss is to be created
      key_vault_name                  = "kv-cus-hub-dev-001"   #(Required) Name of the key vault in which password information is to be stored
      key_vault_resource_group_name   = "rg-cus-app-dev-001"   #(Required) Name of the resource group in which key vault is present
      sku                             = "Standard_F2"          #(Required) The Virtual Machine SKU for the Scale Set, such as Standard_F2
      instances                       = 1                      #(Required) The number of Virtual Machines in the Scale Set
      zones                           = null                   #(Optional) Specifies a list of Availability Zones in which this Linux Virtual Machine Scale Set should be located
      admin_username                  = "azureuser"            #(Required) The username of the local administrator on each Virtual Machine Scale Set instance
      adminuser_key_vault_secret_name = "azureuser"            #(Required) Name of the key vault secret where admin username is to be stored
      password_key_vault_secret_name  = "winvmsspassword"      #(Required) Name of the key vault secret where admin password is to be stored
      upgrade_mode                    = "Automatic"            #(Optional) Specifies how Upgrades (e.g. changing the Image/SKU) should be performed to Virtual Machine Instances. Possible values are Automatic, Manual and Rolling. Defaults to Manual
      rolling_upgrade_policy = {
        max_batch_instance_percent              = 20     #(Required if upgrade_mode is set to Rolling or Automatic) The maximum percent of total virtual machine instances that will be upgraded simultaneously by the rolling upgrade in one batch
        max_unhealthy_instance_percent          = 20     #(Required if upgrade_mode is set to Rolling or Automatic) The maximum percentage of the total virtual machine instances in the scale set that can be simultaneously unhealthy, either as a result of being upgraded, or by being found in an unhealthy state by the virtual machine health checks before the rolling upgrade aborts
        max_unhealthy_upgraded_instance_percent = 20     #(Required if upgrade_mode is set to Rolling or Automatic) The maximum percentage of upgraded virtual machine instances that can be found to be in an unhealthy state. This check will happen after each batch is upgraded
        pause_time_between_batches              = "PT0S" #(Required if upgrade_mode is set to Rolling or Automatic) The wait time between completing the update for all virtual machines in one batch and starting the next batch. The time duration should be specified in ISO 8601 format
      }
      source_image_id = null #(Optional) The ID of an Image which each Virtual Machine in this Scale Set should be based on
      source_image_reference = {
        publisher = "MicrosoftWindowsServer"                                                                                                                                            #(Optional) Specifies the publisher of the image used to create the virtual machines
        offer     = "WindowsServer"                                                                                                                                                     #(Optional) Specifies the offer of the image used to create the virtual machines
        sku       = "2016-Datacenter-Server-Core"                                                                                                                                       #(Optional) Specifies the SKU of the image used to create the virtual machines
        version   = "latest"                                                                                                                                                            #(Optional) Specifies the version of the image used to create the virtual machines
      }                                                                                                                                                                                 #
      os_disk_caching              = "ReadWrite"                                                                                                                                        #(Required) The Type of Caching which should be used for the Internal OS Disk. Possible values are None, ReadOnly and ReadWrite
      os_disk_storage_account_type = "Standard_LRS"                                                                                                                                     #(Required) The Type of Storage Account which should back this the Internal OS Disk. Possible values include Standard_LRS, StandardSSD_LRS and Premium_LRS
      disk_encryption_set_id_os    = "/subscriptions/17cd1d3c-2faf-4967-9ecf-861c10f9f12e/resourceGroups/rg-cus-app-dev-001/providers/Microsoft.Compute/diskEncryptionSets/diskiacvmss" #(Optional) The ID of the Disk Encryption Set which should be used to encrypt this OS Disk
      data_disk = {
        data_disk_caching              = "ReadWrite"                                                                                                                                        #(Required) The type of Caching which should be used for this Data Disk. Possible values are None, ReadOnly and ReadWrite
        data_disk_create_option        = "Empty"                                                                                                                                            #(Optional) The create option which should be used for this Data Disk. Possible values are Empty and FromImage. Defaults to Empty (FromImage should only be used if the source image includes data disks)
        data_disk_lun                  = "0"                                                                                                                                                #(Required) The Logical Unit Number of the Data Disk, which must be unique within the Virtual Machine
        data_disk_size                 = "10"                                                                                                                                               #(Required) The size of the Data Disk in GB which should be created 
        data_disk_storage_account_type = "Standard_LRS"                                                                                                                                     #(Required) The Type of Storage Account which should back this Data Disk. Possible values include Standard_LRS, StandardSSD_LRS, Premium_LRS and UltraSSD_LRS
        disk_encryption_set_id_disk    = "/subscriptions/17cd1d3c-2faf-4967-9ecf-861c10f9f12e/resourceGroups/rg-cus-app-dev-001/providers/Microsoft.Compute/diskEncryptionSets/diskiacvmss" #(Optional) The ID of the Disk Encryption Set which should be used to encrypt this Data Disk
      }
      identiy_type                                 = "UserAssigned"                                                                                                                                                 #(Required) Specifies the type of Managed Service Identity that should be configured on this Linux Virtual Machine Scale Set. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both)
      identity_ids                                 = ["/subscriptions/17cd1d3c-2faf-4967-9ecf-861c10f9f12e/resourceGroups/rg-cus-app-dev-001/providers/Microsoft.ManagedIdentity/userAssignedIdentities/test_vmss"] #(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Linux Virtual Machine Scale Set
      enable_accelerated_networking                = false                                                                                                                                                          #(Optional) Does this Network Interface support Accelerated Networking? Defaults to false
      enable_ip_forwarding                         = false                                                                                                                                                          #(Optional) Does this Network Interface support IP Forwarding? Defaults to false
      application_gateway_backend_address_pool_ids = null                                                                                                                                                           #(Optional) A list of Backend Address Pools ID's from a Application Gateway which this Virtual Machine Scale Set should be connected to
      application_security_group_ids               = null                                                                                                                                                           #(Optional) A list of Application Security Group ID's which this Virtual Machine Scale Set should be connected to
      lb_backend = {
        lb_backend_pool_name   = null #(Optional) Name of loadbalancer backend pool
        lb_name                = null #(Optional) Name of loadbalancer
        lb_nat_pool_name       = null #(Optional) Name of loadbalancer nat pool
        lb_probe_name          = null #(Optional) Name of loadbalancer health probe
        lb_resource_group_name = null #(Optional) Name of resource group of loadbalancer
      }
      vnet_name                = "vnet-cus-hub-dev-001"      #(Required) Name of virtual network
      vnet_resource_group_name = "rg-cus-app-dev-001"        #(Required) Name of resource group of virtual network
      subnet_name              = "sn-cus-sharedservices-dev" #(Required) Name of subnet
      additional_tags = {
        "key" = "value"
      }
    }
  }
  autoscale_settings = {
    vmssa1 = {
      autoscale_name    = "vmssa1"               #(Required) Name of the autoscale setting
      vmss_name         = "vmss-cus-app-dev-web" # Specifies the name of vmss on which autoscale setting is to be applied
      profile_name      = "defaultprofile"       # Specifies the profile name
      default_instances = 1                      # Specifies the number of instances that are available for scaling if metrics are not available for evaluation
      minimum_instances = 1                      # Specifies minimum number of instances for this resource
      maximum_instances = 3                      # Specifies maximum number of instances for this resource
      rule = {
        rule1 = {
          metric_name      = "Percentage CPU" # "Percentage CPU for Virtual Machine Scale Sets and CpuPercentage for App Service Plan"
          time_grain       = "PT5M"           # "value must be between 1 minute and 12 hours an be formatted as an ISO 8601 string"
          statistic        = "Average"        # "Average, Min, Max"
          time_window      = "PT5M"           # "value must be between 5 minutes and 12 hours and be formatted as an ISO 8601 string"
          time_aggregation = "Average"        # "Average, Count, Maximum, Minimum, Last, Total"
          operator         = "GreaterThan"    # "Equals, NotEquals, GreaterThan, GreaterThanOrEqual, LessThan, LessThanOrEqual"
          threshold        = 75               # Specifies the threshold of the metric that triggers the scale action
          direction        = "Increase"       # "Increase, Decrease"
          type             = "ChangeCount"    # "ChangeCount, ExactCount, PercentChangeCount, ServiceAllowedNextValue"
          value            = "1"              # The number of instances involved in the scaling action
          cooldown         = "PT1M"           # "Must be between 1 minute and 1 week and formatted as a ISO 8601 string"
        }
      }
    }
  }
  depends_on = [
    module.resource_group,
    module.virtual_network,
    moduel.subnet,
    module.disk_encryption_set,
    module.keyvault
  ]
}