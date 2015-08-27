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

set :public_folder, File.dirname(__FILE__) + '/public'

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

###################
## Map functions ##
###################

## get map
get '/projects/:id/capability_maps' do
  CapabilityMap.where(project_id: params['id']).all.to_json
end
