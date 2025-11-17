param appServiceName string
param storageAccountName string
param storageAccountResourceGroup string
param storageAccountMountName string
param shareName string
param appServicePlanName string
param location string = resourceGroup().location

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'S1'
    tier: 'standard'
  }
  kind: 'app'
}
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot' // Options: Hot, Cool (for BlobStorage/StorageV2)
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    supportsHttpsTrafficOnly: true
  }
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

