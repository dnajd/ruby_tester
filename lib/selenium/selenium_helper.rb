class SeleniumHelper

	# screen grab errors
	def self.screen_grab_error(driver)
	    begin
	      	yield
	    rescue => error
			timestamp = Time.now.to_i
	      	driver.save_screenshot("./spec/reports/error_#{timestamp}.png")
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