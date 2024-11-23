// target scope
targetScope = 'subscription'

/***************************************************************************************************************************
 *
 * az deployment sub create --location westeurope --template-fil deploy-rg.bicep --parameters  deploy-rg.json
 *
 ****************************************************************************************************************************/

// Parametry
param rgName string
param location string

// Resource Group
resource rg 'Microsoft.Resources/resourceGroups@2024-03-01' = {
  name: rgName
  location: location
}
