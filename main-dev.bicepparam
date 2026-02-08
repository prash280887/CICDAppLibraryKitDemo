using './main.bicep'

var environment = 'dev'

param storageAccountName = 'stgmyappdev${uniqueString(resourceGroup().name)}'
param location = 'eastus'
param storageSku = 'Standard_LRS'

param tags = {
  Environment: 'dev'
  Project: 'AzureBicepsDemo'
}

