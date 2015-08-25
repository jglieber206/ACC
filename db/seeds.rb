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
  attribute_id: 1,
  component_id: 1,
  project_id: 1,
  active: true)
Capability.create(name: "c2",
  attribute_id: 1,
  component_id: 2,
  project_id: 1,
  active: true)
Capability.create(name: "c3",
  attribute_id: 2,
  component_id: 3,
  project_id: 2,
  active: true)
Capability.create(name: "c4",
  attribute_id: 3,
  component_id: 3,
  project_id: 2,
  active: true)
Capability.create(name: "c5",
  attribute_id: 5,
  component_id: 5,
  project_id: 3,
  active: true)
Capability.create(name: "c6",
  attribute_id: 5,
  component_id: 6,
  project_id: 3,
  active: true)
Capability.create(name: "c7",
  attribute_id: 7,
  component_id: 7,
  project_id: 4,
  active: true)
Capability.create(name: "c8",
  attribute_id: 9,
  component_id: 9,
  project_id: 5,
  active: true)
Capability.create(name: "c9",
  attribute_id: 11,
  component_id: 11,
  project_id: 6,
  active: true)
