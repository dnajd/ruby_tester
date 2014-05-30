require "rubygems"
require "selenium-webdriver"
require 'require_all'
require 'minitest/autorun'
require "rest_client"
require "json"
dir = File.dirname(__FILE__)
require_all "#{dir}/../../**/page_objects/**/*.rb"
require_all "#{dir}/../**/log4r/**/*.rb"
require_all "#{dir}/../**/selenium/**/*.rb"