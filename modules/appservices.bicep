param location string = resourceGroup().location
param appServicePlanName string
param appServiceName string
param appServicePlanSku string = 'B1'
param aspNetCoreVersion string = 'v8.0'

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: appServicePlanSku
    tier: 'Basic'
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

resource appService 'Microsoft.Web/sites@2023-01-01' = {
  name: appServiceName
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|${aspNetCoreVersion}'
      alwaysOn: true
    }
  }
}

output appServiceId string = appService.id
output appServiceName string = appService.name
output appServicePlanId string = appServicePlan.id