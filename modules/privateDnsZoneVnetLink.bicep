// private DNS zone vnet Link w/ autoregistration of VMs (pro připojování jednotlivých vnet k privátní zóně)

// parameters
param privateZoneName string                                               // jméno privátní zóny pro získání existujícího objektu (depends)
param vnetId          string                                               // ID virtuální sítě, kterou chceme propojit
param vnetName        string                                               // vnet name pro sestavení jména linku

// Odkaz na existující privátní DNS zónu (! nejde předat objekt jako v TF! :/ )
resource existingPrivateDnsZone 'Microsoft.Network/privateDnsZones@2024-06-01' existing = {
  name: privateZoneName
}

// Vytvoření odkazu na VNet pro DNS zónu
resource vnetLink 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: existingPrivateDnsZone                                           // Odkaz na existující DNS zónu jako rodičovský resource
  location: 'global'                                                       // Pro privátní DNS odkazy je lokace vždy 'global'
  name: '${existingPrivateDnsZone.name}-${vnetName}'
  properties: {
    registrationEnabled: true                                              // Povolí automatickou registraci VM v této síti
    virtualNetwork: {
      id: vnetId
    }
  }
}
