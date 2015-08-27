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

Capability.create(name: "c1",
  project_id: 1,
  code: "user code here",
  url: "www.apptentive.com",
  oauth: "oauth credentials",
  last_result: true)
Capability.create(name: "c2",
  project_id: 1,
  code: "user code here",
  url: "www.apptentive.com",
  oauth: "oauth credentials",
  last_result: true)
Capability.create(name: "c3",
  project_id: 2,
  code: "user code here",
  url: "www.apptentive.com",
  oauth: "oauth credentials",
  last_result: true)
Capability.create(name: "c4",
  project_id: 2,
  code: "user code here",
  url: "www.apptentive.com",
  oauth: "oauth credentials",
  last_result: true)
Capability.create(name: "c5",
  project_id: 3,
  code: "user code here",
  url: "www.apptentive.com",
  oauth: "oauth credentials",
  last_result: true)
Capability.create(name: "c6",
  project_id: 3,
  code: "user code here",
  url: "www.apptentive.com",
  oauth: "oauth credentials",
  last_result: true)
Capability.create(name: "c7",
  project_id: 4,
  code: "user code here",
  url: "www.apptentive.com",
  oauth: "oauth credentials",
  last_result: true)
Capability.create(name: "c8",
  project_id: 5,
  code: "user code here",
  url: "www.apptentive.com",
  oauth: "oauth credentials",
  last_result: true)
Capability.create(name: "c9",
  project_id: 6,
  code: "user code here",
  url: "www.apptentive.com",
  oauth: "oauth credentials",
  last_result: true)

CapabilityMap.create(project_id: 1,
  attribute_id: 1,
  component_id: 1,
  capability_id: 1)
CapabilityMap.create(project_id: 1,
  attribute_id: 1,
  component_id: 1,
  capability_id: 2)
CapabilityMap.create(project_id: 1,
  attribute_id: 1,
  component_id: 2,
  capability_id: 1)
CapabilityMap.create(project_id: 1,
  attribute_id: 2,
  component_id: 1,
  capability_id: 2)
CapabilityMap.create(project_id: 1,
  attribute_id: 2,
  component_id: 2,
  capability_id: 2)
CapabilityMap.create(project_id: 2,
  attribute_id: 3,
  component_id: 3,
  capability_id: 4)
CapabilityMap.create(project_id: 2,
  attribute_id: 3,
  component_id: 4,
  capability_id: 3)
CapabilityMap.create(project_id: 2,
  attribute_id: 3,
  component_id: 4,
  capability_id: 4)
CapabilityMap.create(project_id: 2,
  attribute_id: 4,
  component_id: 3,
  capability_id: 3)
CapabilityMap.create(project_id: 2,
  attribute_id: 4,
  component_id: 3,
  capability_id: 4)

# CapabilityMap layout
# id    proj    attr    comp    cap
# 1     1       1       1       1
# 2     1       1       1       2
# 3     1       1       2       1
# 4     1       2       1       2
# 5     1       2       2       2
# _________________________________
# 6     2       3       3       4
# 7     2       3       4       3
# 8     2       3       4       4
# 9     2       4       3       3
# 10    2       4       3       4
