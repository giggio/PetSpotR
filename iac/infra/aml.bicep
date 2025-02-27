// You don't have issues open, so I'm informing you that this deployment is failing with "Bad request":
// {
//     "status": "Failed",
//     "error": {
//         "code": "ValidationError",
//         "target": "workspace",
//         "message": "Missing dependent resources in workspace json",
//         "details": [
//             {
//                 "code": "Invalid",
//                 "target": "workspace",
//                 "message": "Missing dependent resources in workspace json",
//                 "details": []
//             }
//         ]
//     }
// }

@description('Azure region to deploy resources into. Defaults to location of target resource group')
param location string = resourceGroup().location

@description('Name of the AML workspace. Defaults to a unique hashed string prefized with "petspotr-"')
param workspaceName string = 'petspotr-${uniqueString(resourceGroup().id)}'

@description('ARM ID of the storage account used by the workspace.')
param storageAccountId string

@description('ARM ID of the Azure Key Vault used by the workspace.')
param keyVaultId string

@description('ARM ID of the Azure Container Registry.')
param containerRegistryId string

@description('ARM ID of the Azure Application Insights resource.')
param applicationInsightsId string

resource workspace 'Microsoft.MachineLearningServices/workspaces@2022-12-01-preview' = {
  name: workspaceName
  location: location
  properties: {
    friendlyName: workspaceName
    storageAccount: storageAccountId
    keyVault: keyVaultId
    containerRegistry: containerRegistryId
    applicationInsights: applicationInsightsId
  }
  identity: {
    type: 'SystemAssigned'
  }
}
