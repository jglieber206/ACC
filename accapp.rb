require 'bundler/setup'
require 'sinatra'
require 'json'

set :public_folder, File.dirname(__FILE__) + '/public'

@@projects = { "0001"=> {
    "id"=> "0001",
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
  "0002"=> {
    "id"=> "0002",
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
  "0003"=> {
    "id"=> "0003",
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
  @@projects[params['id']].to_json
end

get '/projects' do
  @@projects.to_json
end

post '/projects' do
  @@projects << @@template
end

#get '/' do
#  File.read('index.html')
#end

delete '/projects/:id' do
  @@projects.delete params['id']
  #remove @@projects[params['id']]
  return 200 # or new list of projects as json
end
