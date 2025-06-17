resource "azurerm_subnet" AZwebsubnet101 {
  name = "websubnet1011"
  resource_group_name = data.azurerm_resource_group.AZrg101.name
  virtual_network_name = azurerm_virtual_network.AZvnet101.name
  address_prefixes = ["10.60.1.0/24"]
}
resource "azurerm_public_ip" "AZwebpublicip101" {
  name = "AZwebpublicip1011"
  location = data.azurerm_resource_group.AZrg101.location
  resource_group_name = data.azurerm_resource_group.AZrg101.name
  allocation_method = "Static"
  
}
resource "azurerm_network_interface" "AZwebnic101" {
  name = "AZwebnic1011"
  location = data.azurerm_resource_group.AZrg101.location
  resource_group_name = data.azurerm_resource_group.AZrg101.name
  ip_configuration {
    name = "webipconfig1011"
    subnet_id = azurerm_subnet.AZwebsubnet101.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.AZwebpublicip101.id
  }
}
resource "azurerm_network_security_group" "AZwebnsg101" {
  name = "AZwebnsg1011"
  location = data.azurerm_resource_group.AZrg101.location
  resource_group_name = data.azurerm_resource_group.AZrg101.name
  security_rule {
    name = "nsg-rule101"
    priority = 100
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "*"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet_network_security_group_association" "AZwebnsgmapping" {
  subnet_id = azurerm_subnet.AZwebsubnet101.id
  network_security_group_id = azurerm_network_security_group.AZwebnsg101.id
}
resource "azurerm_linux_virtual_machine" "AZwebVM101" {
  name = "AZwebVM1011"
  location = data.azurerm_resource_group.AZrg101.location
  resource_group_name = data.azurerm_resource_group.AZrg101.name
  size = "Standard_B1s"
  admin_username = "adminwebuser"
  network_interface_ids = [azurerm_network_interface.AZwebnic101.id,]
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