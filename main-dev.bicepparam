using './main.bicep'

param storageAccountName = 'stgmyappdevdev001'
param location = 'eastus'
param storageSku = 'Standard_LRS'

param tags = {
  Environment: 'dev'
  Project: 'AzureBicepsDemo'
}

