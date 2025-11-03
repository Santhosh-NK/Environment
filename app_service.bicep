param appServiceName string
param storageAccountName string
param storageAccountResourceGroup string
param storageAccountMountName string
param shareName string
param appServicePlanName string
param location string = resourceGroup().location

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: locatio
  sku: {
    name: 'S1'
    tier: 'standard'
  }
  kind: 'app'
}

resource appService 'Microsoft.Web/sites@2022-03-01' = {
  name: appServiceName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      azureStorageAccounts: appServiceName == 'storageaccount-appservice1508' ?{
        'santhosh-filemount' : {
          type: 'AzureFiles'
          accountName: storageAccountName
          shareName: shareName
          accessKey: listKeys(resourceId(storageAccountResourceGroup, 'Microsoft.Storage/storageAccounts', storageAccountName), '2025-01-01').keys[0].value
          mountPath: '/mounts/${storageAccountMountName}'
        }
      }:null
    }
  }
}

