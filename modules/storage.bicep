// Storage Account Module
// This module creates a storage account with configurable parameters

@minLength(3)
@maxLength(24)
@description('Name of the storage account (must be globally unique)')
param storageAccountName string

@description('Resource location')
param location string = resourceGroup().location

@description('Storage account SKU')
@allowed([
  'Standard_LRS'
  'Standard_GRS'
  'Standard_RAGRS'
  'Standard_ZRS'
  'Premium_LRS'
  'Premium_ZRS'
])
param skuName string = 'Standard_LRS'

@description('Storage account kind')
@allowed([
  'Storage'
  'StorageV2'
  'BlobStorage'
  'FileStorage'
  'BlockBlobStorage'
])
param storageAccountKind string = 'StorageV2'

@description('Access tier for the storage account')
@allowed([
  'Hot'
  'Cool'
])
param accessTier string = 'Hot'

@description('Enable HTTPS traffic only')
param httpsOnly bool = true

@description('Minimum TLS version')
@allowed([
  'TLS1_0'
  'TLS1_1'
  'TLS1_2'
])
param minimumTlsVersion string = 'TLS1_2'

@description('Tags to apply to resources')
param tags object = {}

// Create the storage account
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  kind: storageAccountKind
  sku: {
    name: skuName
  }
  properties: {
    accessTier: accessTier
    httpsOnly: httpsOnly
    minimumTlsVersion: minimumTlsVersion
    supportsHttpsTrafficOnly: httpsOnly
  }
  tags: tags
}

// Outputs
@description('Storage account ID')
output storageAccountId string = storageAccount.id

@description('Storage account name')
output storageAccountName string = storageAccount.name

@description('Blob endpoint')
output blobEndpoint string = storageAccount.properties.primaryEndpoints.blob

@description('Primary connection string')
output primaryConnectionString string = 'DefaultEndpointProtocol=https;AccountName=${storageAccount.name};AccountKey=${listKeys(storageAccount.id, storageAccount.apiVersion).keys[0].value};EndpointSuffix=core.windows.net'
