# config.ru
require 'rubygems'
require 'bundler'
require 'raven'
require 'sinatra'
require './accapp'

Raven.configure() do |config|
  config.dsn = ENV['SENTRY']
end

use Raven::Rack

run Sinatra::Application
