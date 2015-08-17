require 'bundler/setup'
require 'sinatra'
require 'json'

set :public_folder, File.dirname(__FILE__) + '/public'
@@last_project = 3
@@projects = { 1 => {
    "id"=> 1,
    "title"=> "Jace's Project",
    "attributes"=> [
      { "name"=> "Fast", "id"=> 1001 },
      { "name"=> "Accurate", "id"=> 1002 },
      { "name"=> "Secure", "id"=> 1003 },
      { "name"=> "Predictable", "id"=> 1004 }
    ],
    "components"=> [
      { "name"=> "dokidoki", "id"=> 2001 },
      { "name"=> "marketing", "id"=> 2002 },
      { "name"=> "love index", "id"=> 2003 }
    ]
  },
  2 => {
    "id"=> 2,
    "title"=> "Drew's Project",
    "attributes"=> [
      { "name"=> "Fast", "id"=> 1001 },
      { "name"=> "Accurate", "id"=> 1002 },
      { "name"=> "Usable", "id"=> 1005 },
      { "name"=> "Stable", "id"=> 1006 }
    ],
    "components"=> [
      { "name"=> "dokidoki", "id"=> 2001 },
      { "name"=> "blog", "id"=> 2004 },
      { "name"=> "admin", "id"=> 2005 }
    ]
  },
  3 => {
    "id"=> 3,
    "title"=> "Joel's Project",
    "attributes"=> [
      { "name"=> "Reliable", "id"=> 1007 },
      { "name"=> "Functional", "id"=> 1008 },
      { "name"=> "Fast", "id"=> 1001 },
      { "name"=> "Stable", "id"=> 1006 }
    ],
    "components"=> [
      { "name"=> "dokidoki", "id"=> 2001 },
      { "name"=> "admin", "id"=> 2005 },
      { "name"=> "love index", "id"=> 2003 }
    ]
  }}
  @@template = {
    "title"=> "New Project",
    "attributes"=> [
      {"name"=> "", "id"=> ""}
    ],
    "components"=> [
      {"name"=> "", "id"=> ""}
    ]
  }

get '/projects/:id' do
  @@projects[params['id'].to_i].to_json
end

get '/projects' do
  @@projects.to_json
end

post '/projects' do
  # request.body.rewind
  payload = JSON.parse(request.body.read)
  @@last_project += 1
  payload['id'] = @@last_project
  @@projects[@@last_project] = payload
end

get '/' do
  File.read('public/index.html')
end

get '/public/:filename' do
  File.read("public/#{params['filename']}")
end

delete '/projects/:id' do
  @@projects.delete params['id'].to_i
  return 200 # or new list of projects as json
end
