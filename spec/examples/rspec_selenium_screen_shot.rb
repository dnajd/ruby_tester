require "rubygems"
require "rspec"
require "selenium-webdriver"
require_relative "../../lib/log4r/log_helper"
require_relative "../../lib/selenium/selenium_helper"

describe "search_google_images" do
 
  # selenium web driver
  before(:all) do
    @driver = Selenium::WebDriver.for :firefox
    @driver.manage.timeouts.implicit_wait = 3 # seconds
    @logger = LogHelper.new.get_logger
  end
  
 
  it "should grab screenshot" do
    
    # find mickey
    @driver.navigate.to "http://images.google.com"
    element = @driver.find_element(:name, 'q')
    element.send_keys "mickey mouse"
    element.send_keys [:return]

    # screen shot
    @driver.save_screenshot("./spec/reports/it_worked.png")

  end

  it "should grab screenshot on failure" do
    
    # load google
    @driver.navigate.to "http://images.google.com"
    element = @driver.find_element(:name, 'q')
    element.send_keys "error"
    element.send_keys [:return]


    SeleniumHelper.screen_grab_error(@driver) do

      # error on purpose
      nil.should eq(true)
    
    end
  end

  # ensure that the browser is shutdown 
  after(:all) do
    @driver.quit
  end
end