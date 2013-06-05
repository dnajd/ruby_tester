################################################
# Drives via Rspec
#
# Rspec Matchers: http://rspec.rubyforge.org/rspec/1.1.9/classes/Spec/Matchers.html
# webdriver: http://seleniumhq.org/docs/03_webdriver.html#introducing-webdriver
# ruby examples: http://code.google.com/p/selenium/wiki/RubyBindings
# api docs: http://selenium.googlecode.com/svn/trunk/docs/api/rb/_index.html
################################################

require "rubygems"
require "rspec"
require "selenium-webdriver"
require_relative "../../lib/log4r/log_helper"
 
describe "search_google" do
 
  # selenium web driver
  before(:all) do
    @driver = Selenium::WebDriver.for :firefox
    @driver.manage.timeouts.implicit_wait = 3 # seconds
    @logger = LogHelper.new.get_logger
  end
  
  it "should load google" do
    
    # navigate
    @driver.navigate.to "http://google.com"
    
    # check page title
    @driver.title.should match(/^Google/)
    
  end
 
  it "should search google" do

    # navigate    
    @driver.navigate.to "http://google.com"

    # search field
    element = @driver.find_element(:name, 'q')
    element.send_keys "Santa Rosa"
    
  end

  # ensure that the browser is shutdown 
  after(:all) do
    @driver.quit
  end
end