require 'minitest/autorun'
require "selenium-webdriver"
require_relative "page_objects/google_home_page"
require_relative "../../lib/log4r/log_helper"
 
class SeleniumPageObjTest < Minitest::Unit::TestCase
 
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
    home_page = GoogleHomePage.new(@driver)
    assert_equal 'Google', home_page.get_title

  end
 
  def test_search_google
    
    # navigate
    @driver.navigate.to "http://google.com"

    # search
    home_page = GoogleHomePage.new(@driver)
    home_page.search("Santa Rosa")
    
  end

end