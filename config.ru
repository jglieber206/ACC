# config.ru
require 'bundler'
require 'rubygems'

Bundler.require

require './app'
run AccApp
