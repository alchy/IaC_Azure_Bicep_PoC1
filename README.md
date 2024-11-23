IaC_Azure_Bicep_PoC1 - private DNS zone 
----------------------------------------
- modul pro vytvoření privátní DNS zóny
- modul pro připojení vNet do privátní DNS zóny)

is it required to have registered providers (az provider register --namespace privateDnsZones)

1) az deployment sub create --location westeurope --template-file deploy-rg.bicep --parameters  deploy-rg.json
2) az deployment group create --resource-group "jn-resource-group" --template-file main.bicep --parameters parameters.json
