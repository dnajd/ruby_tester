require "rubygems"
require 'minitest/autorun'
require "selenium-webdriver"
require_relative "../../lib/log4r/log_helper"
require_relative "../../lib/selenium/selenium_helper"

class SeleniumScreenShotTest < Minitest::Unit::TestCase
 
  def setup
    @logger = LogHelper.new.get_logger
    @driver = Selenium::WebDriver.for :firefox
    @driver.manage.timeouts.implicit_wait = 3 # seconds
  end

  def teardown
    @driver.quit
  end

 
  def test_screenshot_mickey
    @driver.navigate.to "http://images.google.com"

    # search for mickey
    element = @driver.find_element(:name, 'q')
    element.send_keys "mickey mouse"
    element.send_keys [:return]

    # screen shot
    @driver.save_screenshot("./test/reports/it_worked.png")
  end

  def test_screenshot_on_error
    @driver.navigate.to "http://images.google.com"

    # search google
    element = @driver.find_element(:name, 'q')
    element.send_keys "error"
    element.send_keys [:return]

    # error on purpose
    SeleniumHelper.screen_grab_error(@driver) do
      assert_equal true, false
    end
  end

end