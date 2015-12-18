# config.ru
require 'rubygems'
require 'bundler'
require 'raven'
require 'sinatra'
require './accapp'
require "rack-timeout"

Raven.configure() do |config|
  config.dsn = ENV['SENTRY']
end
use Raven::Rack

use Rack::Timeout
Rack::Timeout.timeout = 5

run Sinatra::Application
