targetScope = 'subscription'

@description('The location where the resource group will be created')
param location string = 'westeurope'

param stage string = 'dev'

resource group 'Microsoft.Resources/resourceGroups@2024-11-01' = {
  name: 'awinds-azure-workshop-${stage}'
  location: location
  tags: {
    stage: 'dev'
    project: 'course-management'
    'hidden-title': 'invisible title'
  }
}
