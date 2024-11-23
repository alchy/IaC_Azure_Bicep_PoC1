// private DNS zone (vytvoří privátní zónu)

// parameters
param zoneName string

// Private DNS Zone
resource privateZone 'Microsoft.Network/privateDnsZones@2024-06-01' = {
  name: zoneName
  location: 'global'
  properties: {}
}

// Výstup pro přístup k DNS Zone
output privateZoneId    string = privateZone.id
output privateZoneName  string = privateZone.name
