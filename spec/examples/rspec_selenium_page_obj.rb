require "rubygems"
require "rspec"
require "selenium-webdriver"
require_relative "page_objects/google_home_page"
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
    home_page = GoogleHomePage.new(@driver)
    home_page.get_title.should match(/^Google/)

  end
 
  it "should search google" do
    
    # navigate
    @driver.navigate.to "http://google.com"

    # search
    home_page = GoogleHomePage.new(@driver)
    home_page.search("Santa Rosa")
    
  end

  # ensure that the browser is shutdown 
  after(:all) do
    @driver.quit
  end
end