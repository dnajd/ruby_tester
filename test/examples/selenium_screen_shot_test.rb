require "rubygems"
require "rspec"
require "selenium-webdriver"
require_relative "../../lib/log4r/log_helper"
require_relative "../../lib/selenium/selenium_helper"

class selenium_screen_shot_test < MiniTest::Test
 
  def setup
    @logger = LogHelper.new.get_logger
  end
 
  def test_screenshot_mickey
    
    # driver
    @driver = Selenium::WebDriver.for :firefox
    @driver.manage.timeouts.implicit_wait = 3 # seconds
    @driver.navigate.to "http://images.google.com"

    # search for mickey
    element = @driver.find_element(:name, 'q')
    element.send_keys "mickey mouse"
    element.send_keys [:return]

    # screen shot
    @driver.save_screenshot("./test/reports/it_worked.png")

    # close driver
    @driver.quit
  end

  def test_screenshot_on_error
    
    # driver
    @driver = Selenium::WebDriver.for :firefox
    @driver.manage.timeouts.implicit_wait = 3 # seconds
    @driver.navigate.to "http://images.google.com"

    # search google
    element = @driver.find_element(:name, 'q')
    element.send_keys "error"
    element.send_keys [:return]

    # error on purpose
    SeleniumHelper.screen_grab_error(@driver) do
      assert_equal true, false
    end

    # close driver
    @driver.quit
  end

end