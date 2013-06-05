require "selenium-webdriver"
require 'require_all'
require "rspec"
require 'rspec-expectations'
require "rest_client"
require "json"
dir = File.dirname(__FILE__)
require_all "#{dir}/../../**/page_objects/**/*.rb"