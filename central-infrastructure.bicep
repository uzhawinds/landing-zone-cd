param projectName string
param adminPrincipalId string
param adminPrincipalId2 string
param tags object

var infraTags = union(tags, {
  Type: 'central-infrastructure'
})

module acrModule './central-acr.bicep' = {
  name: '${deployment().name}-acrDeploy'
  params: {
    projectName: projectName
    adminPrincipalId: adminPrincipalId
    adminPrincipalId2: adminPrincipalId2
    tags: infraTags
  }
}

module monitorModule './central-monitor.bicep' = {
  name: '${deployment().name}-monitorDeploy'
  params: {
    projectName: projectName
    tags: infraTags
  }
}

output registryName string = acrModule.outputs.registryName
