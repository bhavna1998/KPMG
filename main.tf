## NOTE: Read all given instructions before updating the values to get the resources created in first run.
## NOTE: example/main.tf to be used for deployment of resources through Gitlab.

module "windows_vm" {
  source              = "git::https://dev.azure.com/dmangeshtambe0819/_git/iac-azure-modules?path=/windowsvm?ref=main"
  windows_vms = [
    {
      name                          = "vm-cus-app-dev-01"      #(Required) Name of windows virtual machine
      resource_group_name           = "rg-cus-app-dev-001"     #(Required) Name of the resource group
      key_vault_name                = "kv-cus-hub-dev-001"     #(Required) Name of the key vault in which password information is to be stored
      key_vault_resource_group_name = "rg-cus-app-dev-001"     #(Required) Name of the resource group in which key vault is present
      admin_password_secret_name    = "winpass01"              #(Required) Name of the key vault secret where admin password is to be stored
      admin_username                = "azureuser"              #(Required) The username of the local administrator on each Virtual Machine Scale Set instance
      size                          = "Standard_F2"            #(Required) The SKU which should be used for this Virtual Machine, such as Standard_F2
      network_interface_names       = ["nic-cus-app-dev-001"]  #(Required) Name of the network interface
      os_disk_storage_account_type  = "StandardSSD_LRS"        #(Required) The Type of Storage Account which should back this the Internal OS Disk. Possible values are Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS
      source_image_publisher        = "MicrosoftWindowsServer" #(Optional) Specifies the publisher of the image used to create the virtual machines
      source_image_offer            = "WindowsServer"          #(Optional) Specifies the offer of the image used to create the virtual machines
      source_image_sku              = "2016-Datacenter"        #(Optional) Specifies the SKU of the image used to create the virtual machines
      source_image_version          = "latest"                 #(Optional) Specifies the version of the image used to create the virtual machines
    }
  ]

  network_interfaces = [
    {
      name = "nic-cus-app-dev-001"
      ip_configurations = [
        {
          name                          = "ip-config-1"               #(Required) Name of the IP configuration
          private_ip_address_allocation = "Dynamic"                   #(Required) The allocation method used for the Private IP Address. Possible values are Dynamic and Static
          public_ip_name                = "pip-cus-app-dev-01"        #(Optional) Name of the public IP
          vnet_name                     = "vnet-cus-hub-dev-001"      #(Required) Namr fo the virtual network
          subnet_name                   = "sn-cus-sharedservices-dev" #(Required) Name of the subnet
        }
      ]
    }
  ]

attach_managed_disks = [
  {
    managed_data_disk_name = "datadisk-cus-app-dev-01" #(Required) Name of the managed disk to attch
    virtual_machine_name   = "vm-cus-app-dev-01"       #(Required) Name of the virtual machine in which the managed disk is to be attached
  }
]

disk_init = [
  {
    virtual_machine_names = ["vm-cus-app-dev-01"]
    partition_style       = "MBR"
    re_run                = false
  }
]
  depends_on = [
    module.resource_group,
    module.virtual_network,
    module.subnet,
    module.keyvault,
    module.disk_encryption_set,
    module.managed_disk
  ]
}