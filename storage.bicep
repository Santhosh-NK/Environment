param storageAccountName string = 'stoarage-afafasd'
param location string = resourceGroup().location
param skuName string = 'Standard_LRS'
param kind string = 'StorageV2'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: skuName
  }
  kind: kind
  properties: {
    accessTier: 'Hot'
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    supportsHttpsTrafficOnly: true
  }
}

output storageAccountId string = storageAccount.id
output storageAccountName string = storageAccount.name
