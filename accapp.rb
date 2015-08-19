require 'bundler/setup'
require 'sinatra'
require 'json'

set :public_folder, File.dirname(__FILE__) + '/public'

# variable declarations

@@projects = {
  1 => {
    "id" => 1,
    "title" => "Jace's Project"
  },
  2 => {
    "id" => 2,
    "title" => "Drew's Project"
  },
  3 => {
    "id" => 3,
    "title" => "Joel's Project"
  }
}

@@attributes = {
  1 => {
    "id" => 1,
    "name" => "Fast",
    "project_id" => 1
  },
  2 => {
    "id" => 2,
    "name" => "Accurate",
    "project_id" => 1
  },
  3 => {
    "id" => 3,
    "name" => "Secure",
    "project_id" => 2
  },
  4 => {
    "id" => 4,
    "name" => "Predictable",
    "project_id" => 2
  },
   5 => {
    "id" => 5,
    "name" => "Fun",
    "project_id" => 3
  },
  6 => {
    "id" => 6,
    "name" => "Simple",
    "project_id" => 3
  }
}
@@components = {
  1 => {
    "id" => 1,
    "name" => "dokidoki",
    "project_id" => 1
  },
  2 => {
    "id" => 2,
    "name" => "marketing",
    "project_id" => 1
  },
  3 => {
    "id" => 3,
    "name" => "blog",
    "project_id" => 2
  },
  4 => {
    "id" => 4,
    "name" => "admin",
    "project_id" => 2
  },
  5 => {
    "id" => 5,
    "name" => "Predictable",
    "project_id" => 3
  },
  6 => {
    "id" => 6,
    "name" => "love index",
    "project_id" => 3
  }
}
  @@last_project = @@projects.length
  @@last_attribute = @@attributes.length
  @@last_component = @@components.length

###############################################
## Project list & general endpoint functions ##
###############################################

## Get all projects
get '/projects' do
  @@projects.to_json
end

## Get project by id
get '/projects/:id' do

  @@projects[params['id'].to_i].to_json
end

## Add new project
post '/projects' do
  payload = JSON.parse(request.body.read)
  @@last_project += 1
  payload['id'] = @@last_project
  @@projects[@@last_project] = payload
end

## Delete specific project (including all properties of project)
delete '/projects/:id' do
  @@projects.delete params['id'].to_i
end

## Route to app functionality
get '/' do
  File.read('public/index.html')
end

## Route to any project file (must specify)
get '/public/:filename' do
  File.read("public/#{params['filename']}")
end

#########################################
## Functions within a specific project ##
#########################################

## Access attributes list for a specified project
get '/projects/:id/attributes' do
  currentProject = @@projects[params['id'].to_i]
  attributeList = {}
  counter = 0
  @@attributes.each do |attribute, value|
    if value['project_id'] == currentProject['id']
      currentAttribute = { counter => value }
      attributeList.merge!(currentAttribute)
      counter += 1
    end
  end
  return attributeList
end

## Access components list for a specified project
get '/projects/:id/components' do
  currentProject = @@projects[params['id'].to_i]
  componentList = {}
  counter = 0
  @@components.each do |component, value|
    if value['project_id'] == currentProject['id']
      currentComponent = { counter => value }
      componentList.merge!(currentComponent)
      counter += 1
    end
  end
  return componentList
end
