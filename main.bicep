// target scope
targetScope = 'resourceGroup'

/***************************************************************************************************************************
 *
 * az deployment group create --resource-group "jn-resource-group" --template-file main.bicep --parameters parameters.json
 *
 ****************************************************************************************************************************/

// Parameters
param location              string
param vnetName              string
param vnetAddressPrefix     string
param subnetName            string
param subnetAddressPrefix   string

// Private zone name
param privateZoneName       string

// Virtual Network
resource vnet 'Microsoft.Network/virtualNetworks@2023-02-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddressPrefix
        }
      }
    ]
  }
}

// Zavolání modulu pro private DNS zone
module privateZone './modules/privateDnsZone.bicep' = {
  name: 'privateZoneModule'
  scope: resourceGroup()
  params: {
    zoneName: privateZoneName
  }
}

// Zavolání modulu pro VNet link (přes modul možno iterovat více linků)
module vnetLinkModule './modules/privateDnsZoneVnetLink.bicep' = {
  name: 'vnetLinkModule'
  scope: resourceGroup()
  params: {
    privateZoneName: privateZone.outputs.privateZoneName
    vnetId: vnet.id                                           // ID virtuální sítě pro join k DNS zóně
    vnetName: vnetName
  }
}
