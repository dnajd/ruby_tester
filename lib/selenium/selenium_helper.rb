class SeleniumHelper

  # Grab screenshots on error. If filename is not provided, timestamp is used.
  # @param [Selenium::WebDriver] driver
  def self.screen_grab_error(driver, filename = nil)

    begin
      yield

    rescue => error
      unless filename
        filename = timestamp
      end

      driver.save_screenshot("#{filename}.png")
      driver.save_screenshot("./test/reports/error_#{timestamp}.png")

      raise
    end
  end

  # wait for element to go away
  def self.wait_element_gone(seconds)
    wait = Selenium::WebDriver::Wait.new(:timeout => seconds) # seconds
    wait.until {
      begin
        yield
        false
      rescue Selenium::WebDriver::Error::NoSuchElementError
        true
      end
    }
  end

  # wait for element to go away
  def self.wait_for(seconds)
    wait = Selenium::WebDriver::Wait.new(:timeout => seconds) # seconds
    wait.until {
      yield
    }
  end

  def self.exists()
    begin
      yield
      true
    rescue Selenium::WebDriver::Error::NoSuchElementError
      false
    end
  end

end
