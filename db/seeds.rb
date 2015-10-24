Project.create(name: "Jace's project")
Project.create(name: "Drew's project")
Project.create(name: "Joel's project")

Attribute.create(name: "Fast", project_id: 1)
Attribute.create(name: "Stable", project_id: 1)
Attribute.create(name: "Secure", project_id: 2)
Attribute.create(name: "Safe", project_id: 2)
Attribute.create(name: "Fun", project_id: 3)
Attribute.create(name: "Effective", project_id: 3)

Component.create(name: "dokidoki", project_id: 1)
Component.create(name: "admin", project_id: 1)
Component.create(name: "blog", project_id: 2)
Component.create(name: "love index", project_id: 2)
Component.create(name: "marketing", project_id: 3)
Component.create(name: "sales", project_id: 3)

# def create_capability(name:, project_id:)
#   seed_url = 'http://jenkins.corp.apptentive.com/view/Test%20-%20Platform/job/Platform_Build_on_Merge_to_Master/lastBuild/api/json?pretty=true'
#   seed_code = '["result"] === "SUCCESS"'
#   Capability.create(name: name,
#                     project_id: project_id,
#                     integration: "jenkins",
#                     code: seed_code,
#                     url: seed_url,
#                     last_result: false)
# end

Capability.create(integration: 'jenkins', name: "Jenkins", project_id: 1, url: 'http://jenkins.corp.apptentive.com/view/Test%20-%20Platform/job/Platform_Build_on_Merge_to_Master/lastBuild/api/json?pretty=true', code: '["result"] === "SUCCESS"')
Capability.create(integration: 'jira', name: "Jira", project_id: 1, url: '/rest/api/latest/issue/MARCOM-94', code: '["id"] === "28237"')
Capability.create(integration: 'dd_event', name: "DataDog Event", project_id: 1, url: 'pingdom', code: '["events"].length >= "0"')
Capability.create(integration: 'dd_metric', name: "DataDog Metric", project_id: 1, url: 'avg:mongo_query.avg{mongo_op:find} by {mongo_collection} * sum:mongo_query.count{mongo_op:find} by {mongo_collection}.as_rate()', code: '["status"] === "ok"')


CapabilityMap.create(project_id: 1,
  attribute_id: 1,
  component_id: 1,
  capability_id: 1)
CapabilityMap.create(project_id: 1,
  attribute_id: 1,
  component_id: 2,
  capability_id: 2)
CapabilityMap.create(project_id: 1,
  attribute_id: 2,
  component_id: 2,
  capability_id: 3)
CapabilityMap.create(project_id: 1,
  attribute_id: 2,
  component_id: 1,
  capability_id: 4)
