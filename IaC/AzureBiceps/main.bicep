@description('Storage Account Name')
param storageAccountName string

@description('Location for resources')
param location string = resourceGroup().location

@description('Storage SKU')
param storageSku string = 'Standard_LRS'

@description('Tags for all resources')
param tags object = {
  Environment: 'dev'
  Project: 'AzureBicepsDemo'
}

// Storage Account Module
module storageModule 'modules/storage.bicep' = {
  name: 'stg-${uniqueString(resourceGroup().id)}'
  params: {
    storageAccountName: storageAccountName
    location: location
    skuName: storageSku
    tags: tags
  }
}

// Outputs
@description('Storage account ID')
output storageAccountId string = storageModule.outputs.storageAccountId

@description('Storage account name')
output storageAccountName string = storageModule.outputs.storageAccountName

@description('Blob endpoint')
output blobEndpoint string = storageModule.outputs.blobEndpoint


module appserviceModule 'modules/appservices.bicep' = {
  name: 'app-${uniqueString(resourceGroup().id)}'
  params: {
    appServiceName: 'myappdev${uniqueString(resourceGroup().name)}'
    appServicePlanName: 'planmyappdev${uniqueString(resourceGroup().name)}'
    appServicePlanSku: 'P1v2'
    location: location
  }

}

@description('appService appServiceName')
output appServiceDefaultHostName string = appserviceModule.outputs.appServiceName

@description('appService Id')
output appServiceId string = appserviceModule.outputs.appServiceId

@description('appService Plan Id')
output appServicePlanId string = appserviceModule.outputs.appServicePlanId
