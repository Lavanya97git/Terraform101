resource "azurerm_subnet" AZwebsubnet101 {
  name = "websubnet1011"
  resource_group_name = azurerm_resource_group.AZrg102.name
  virtual_network_name = azurerm_virtual_network.AZvnet101.name
  address_prefixes = ["10.60.1.0/24"]
}
resource "azurerm_public_ip" "AZwebpublicip101" {
  count = var.vm_count
  name = "${var.vm_name_pfx}-${count.index}-ip"
  location = azurerm_resource_group.AZrg102.location
  resource_group_name = azurerm_resource_group.AZrg102.name
  allocation_method = "Static"
  
}
resource "azurerm_network_interface" "AZwebnic101" {
  count = var.vm_count
  name = "${var.vm_name_pfx}-${count.index}-nic"
  #here instead of 'count.index' can use this too 'var.vm_count'
  location = azurerm_resource_group.AZrg102.location
  resource_group_name = azurerm_resource_group.AZrg102.name
  ip_configuration {
    name = "webipconfig1011"
    subnet_id = azurerm_subnet.AZwebsubnet101.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.AZwebpublicip101[count.index].id
  }
}
resource "azurerm_linux_virtual_machine" "AZwebVM101" {
  count = var.vm_count
  name = "${var.vm_name_pfx}-${count.index}-VM"
  location = azurerm_resource_group.AZrg102.location
  resource_group_name = azurerm_resource_group.AZrg102.name
  size = "Standard_B1s"
  admin_username = "adminwebuser"
  network_interface_ids = [azurerm_network_interface.AZwebnic101[count.index].id,]
  admin_ssh_key {
    username = "adminwebuser"
    public_key = file("~/.ssh/id_ed25519.pub")
  }
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer = "0001-com-ubuntu-server-jammy"
    sku = "22_04-lts"
    version = "latest"
  }
}