IaC_Azure_Bicep_PoC1 - private DNS zone

is it required to have registered providers (az provider register --namespace privateDnsZones)

respecitve az deployment commands in the files (deploy-rg.bicep and main.bicep)
1) az deployment sub create --location westeurope --template-file deploy-rg.bicep --parameters  deploy-rg.json
2) az deployment group create --resource-group "jn-resource-group" --template-file main.bicep --parameters parameters.json
