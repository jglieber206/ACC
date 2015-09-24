require 'bundler/setup'
require 'sinatra'
require 'sinatra/activerecord'
require './config/environments'
require './models/project'
require './models/attribute'
require './models/component'
require './models/capability'
require './models/capability_map'
require 'pg'
require 'json'
require 'rufus-scheduler'
require './helpers/result_fetcher'

set :public_folder, File.dirname(__FILE__) + '/public'

@@fetcher = ResultFetcher.new
@@scheduler = Rufus::Scheduler.new
@@scheduler.every '30s' do
  @@fetcher.run
end


###############################################
## Project list & general endpoint functions ##
###############################################

## Get all projects
get '/projects' do
  Project.all.to_json
end

## Get project by id
get '/projects/:id' do
  Project.find(params['id'].to_i).to_json
end

## Add new project
post '/projects' do
  payload = request.body.read
  new_project = Project.new(name: payload)
  new_project.save
end

## Delete specific project (including all properties of project)
delete '/projects/:id' do
  project = Project.find(params['id'].to_i)
  project.destroy
end

## Route to app functionality
get '/' do
  File.read('public/index.html')
end

## Route to any project file (must specify)
get '/public/:filename' do
  File.read("public/#{params['filename']}")
end

#########################
## Attribute functions ##
#########################

## Access attributes list for a specified project
get '/projects/:id/attributes' do
  Attribute.where(project_id: params['id']).all.to_json
end

post '/projects/:id/attributes' do
  payload = request.body.read
  new_attribute = Attribute.new(name: payload, project_id: params['id'].to_i)
  new_attribute.save
end

delete '/attributes/:id' do
  attribute = Attribute.find(params['id'].to_i)
  attribute.destroy
end

#########################
## Component functions ##
#########################

## Access components list for a specified project
get '/projects/:id/components' do
  Component.where(project_id: params['id']).all.to_json
end

post '/projects/:id/components' do
  payload = request.body.read
  new_component = Component.new(name: payload, project_id: params['id'].to_i)
  new_component.save
end

delete '/components/:id' do
  component = Component.find(params['id'].to_i)
  component.destroy
end
##########################
## Capability functions ##
##########################

## get all capabilities for a project
get '/projects/:id/capabilities' do
  Capability.where(project_id: params['id']).all.to_json
end

## get capabilities for an attribute/component intersection
get '/attributes/:attr_id/components/:comp_id' do
  tmp = []
  CapabilityMap.where(attribute_id: params['attr_id'], component_id: params['comp_id']).each do |map|
    tmp << map.capability_id
  end
  capList = Capability.where(id: tmp).all.to_json
  return capList
end

## add new capability to attribute/component intersection
post '/attributes/:attr_id/components/:comp_id' do
  data = JSON.parse request.body.read
  new_capability = Capability.new(name: data['name'], project_id: data['project_id'], code: data['code'], url: data['url'], oauth: data['oauth'])
  new_capability.save
  @@fetcher.add(new_capability)
  CapabilityMap.new(project_id: data['project_id'], attribute_id: params['attr_id'], component_id: params['comp_id'], capability_id: new_capability.id).save
end

## update capability
post '/capabilities/update/:id' do
  data = JSON.parse request.body.read
  capability = Capability.find(params['id'])
  capability.update(name: data['name'], code: data['code'], url: data['url'], oauth: data['oauth'])

end

delete '/capabilities/:id' do
  capability = Capability.find(params['id'])
  map = CapabilityMap.where(capability_id: params['id'])
  capability.destroy
  map.destroy_all
  "Map Destroyed"
end

###################
## Map functions ##
###################

## get map
get '/projects/:id/capability_maps' do
  CapabilityMap.where(project_id: params['id']).all.to_json
end
