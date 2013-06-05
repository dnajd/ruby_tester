class GoogleHomePage
	
	def initialize(driver)
		@driver = driver
	end

	def get_title()
		@driver.title
	end

	def search(value)
	   	# search field
	    element = @driver.find_element(:name, 'q')
	    element.send_keys value
	end
end