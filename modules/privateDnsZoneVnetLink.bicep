// private DNS zone vnet Link w/ autoregistration of VMs

// parameters
param privateZoneName string            // 
param vnetId          string            // ID virtuální sítě, kterou chceme propojit
param vnetName        string            // vnet name

// Odkaz na existující privátní DNS zónu (! nejde předat objekt! :/ )
resource existingPrivateDnsZone 'Microsoft.Network/privateDnsZones@2024-06-01' existing = {
  name: privateZoneName
}

// Vytvoření odkazu na VNet pro DNS zónu
resource vnetLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: existingPrivateDnsZone                                           // Odkaz na existující DNS zónu jako rodičovský resource
  location: resourceGroup().location
  name: '${existingPrivateDnsZone.name}-${vnetName}'
  properties: {
    registrationEnabled:    true                                          // Povolí automatickou registraci VM v této síti
    virtualNetwork: {
      id: vnetId
    }
  }
}
