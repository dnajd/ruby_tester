require 'minitest/autorun'
require "selenium-webdriver"
require_relative "page_objects/google_home_page"
require_relative "../../lib/log4r/log_helper"
 
class selenium_page_obj_test < MiniTest::Test
 
  def setup
    @logger = LogHelper.new.get_logger
  end

  def test_load_google
    
    # navigate
    @driver = Selenium::WebDriver.for :firefox
    @driver.manage.timeouts.implicit_wait = 3 # seconds
    @driver.navigate.to "http://google.com"
    
    # check page title
    home_page = GoogleHomePage.new(@driver)
    home_page.get_title.should match(/^Google/)

    # close driver
    @driver.quit
  end
 
  def test_search_google
    
    # navigate
    @driver = Selenium::WebDriver.for :firefox
    @driver.manage.timeouts.implicit_wait = 3 # seconds
    @driver.navigate.to "http://google.com"

    # search
    home_page = GoogleHomePage.new(@driver)
    home_page.search("Santa Rosa")

    # close driver
    @driver.quit
    
  end

end