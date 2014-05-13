################################################
# webdriver: http://seleniumhq.org/docs/03_webdriver.html#introducing-webdriver
# ruby examples: http://code.google.com/p/selenium/wiki/RubyBindings
# api docs: http://selenium.googlecode.com/svn/trunk/docs/api/rb/_index.html
################################################

require "rubygems"
require 'minitest/autorun'
require "selenium-webdriver"
require_relative "../../lib/log4r/log_helper"

class SeleniumTest < Minitest::Unit::TestCase
 
  def setup
    @logger = LogHelper.new.get_logger
    @driver = Selenium::WebDriver.for :firefox
    @driver.manage.timeouts.implicit_wait = 3 # seconds
  end
  
  def teardown
    @driver.quit
  end

  def test_load_google
    
    # navigate
    @driver.navigate.to "http://google.com"
    
    # check page title
    assert_equal 'Google', @driver.title

    
  end
 
  def test_search_google

    # navigate   
    @driver.navigate.to "http://google.com"

    # search field
    element = @driver.find_element(:name, 'q')
    element.send_keys "Santa Rosa"
    
  end

end