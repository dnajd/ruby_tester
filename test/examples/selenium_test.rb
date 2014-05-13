################################################
# webdriver: http://seleniumhq.org/docs/03_webdriver.html#introducing-webdriver
# ruby examples: http://code.google.com/p/selenium/wiki/RubyBindings
# api docs: http://selenium.googlecode.com/svn/trunk/docs/api/rb/_index.html
################################################

require "rubygems"
require 'minitest/autorun'
require "selenium-webdriver"
require_relative "../../lib/log4r/log_helper"
 

class selenium_test < MiniTest::Test
 
  def setup
    @logger = LogHelper.new.get_logger
  end
  
  def test_load_google
    
    # navigate
    @driver = Selenium::WebDriver.for :firefox
    @driver.manage.timeouts.implicit_wait = 3 # seconds
    @driver.navigate.to "http://google.com"
    
    # check page title
    @driver.title.should match(/^Google/)

    # close driver
    @driver.quit
    
  end
 
  def test_search_google

    # navigate   
    @driver = Selenium::WebDriver.for :firefox
    @driver.manage.timeouts.implicit_wait = 3 # seconds 
    @driver.navigate.to "http://google.com"

    # search field
    element = @driver.find_element(:name, 'q')
    element.send_keys "Santa Rosa"

    # close driver
    @driver.quit
    
  end

end