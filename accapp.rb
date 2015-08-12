require 'bundler/setup'
require 'sinatra'
require 'json'

@@projects = [{
    "name"=> "Jace's Project",
    "id"=> 0001,
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
  {
    "name"=> "Drew's Project",
    "id"=> 0002,
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
  }]


get '/projects' do
  @@projects.to_json
end

get '/' do
  Read.file('public/index.html')
end

get 'projects/:id' do
  @@projects[id].to_json
end

get '/public/:filename' do
  # return params["filename"]
  File.read("public/#{params['filename']}")
end

delete '/projects/:id' do
  # remove @@projects["id"] figure out syntax
  return 200
end
