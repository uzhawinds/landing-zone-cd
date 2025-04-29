param location string = resourceGroup().location
param projectName string
param tags object
param adminPrincipalId string
param adminPrincipalId2 string

var abbrs = loadJsonContent('abbreviations.json')
var roles = loadJsonContent('azure-roles.json')

// Create container registry
resource registry 'Microsoft.ContainerRegistry/registries@2024-11-01-preview' = {
  name: '${abbrs.containerRegistryRegistries}${uniqueString(projectName)}'
  location: location
  tags: tags
  sku: {
    name: 'Basic' // Choose a different SKU if needed.
                  // Consider making this a parameter if you need more flexibility.
  }
  properties: {}
}

// Assign the 'AcrPush', 'AcrDelete', and 'AcrPull' roles to the admin principal.
resource registryPushAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(registry.id, adminPrincipalId, 'push')
  scope: registry
  properties: {
    principalId: adminPrincipalId
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roles.AcrPush)
  }
}

resource registryDeleteAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(registry.id, adminPrincipalId, 'delete')
  scope: registry
  properties: {
    principalId: adminPrincipalId
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roles.AcrDelete)
  }
}

resource registryPullAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(registry.id, adminPrincipalId, 'pull')
  scope: registry
  properties: {
    principalId: adminPrincipalId
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roles.AcrPull)
  }
}

resource registryPullAssignment2 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(registry.id, adminPrincipalId2, 'pull')
  scope: registry
  properties: {
    principalId: adminPrincipalId2
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roles.AcrPull)
  }
}

// Assign the 'AcrPush', 'AcrDelete', and 'AcrPull' roles to the admin principal.
resource registryPushAssignment2 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(registry.id, adminPrincipalId2, 'push')
  scope: registry
  properties: {
    principalId: adminPrincipalId2
    roleDefinitionId: resourceId('Microsoft.Authorization/roleDefinitions', roles.AcrPush)
  }
}

output registryName string = registry.name
