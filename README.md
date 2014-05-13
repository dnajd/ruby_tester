Ruby Test
================
Test web applications or rest services

Getting Started
================
The test folder has examples of:

* testing a rest service
* testing a webpage with selenium
* testing a webpage using selenium and the page object pattern

Running the Tests
=================
Run all tests

	bundle execute rake test

Interactive Selenium
---------------------
The default rake task will:

* load up irb
* include selnium
* include any page objects you've created

Get started by running

	bundle exec rake

Once in the irb, use selenium

	driver = Selenium::WebDriver.for :firefox
	driver.navigate.to "http://google.com"

And page objects

	# create page object
	page_obj = GoogleHomePage.new(driver)

	# use page object
    page_obj.search("Santa Rosa")

Logs & Reports
=================
ci_report can be generated for build automation; refer to the Rakefile to see an example

r4log can be used to send output to 

* the console
* a log file
* splunk storm

Additional Notes
==================
To test with chrome you need:

* Download correct <a href="https://code.google.com/p/chromedriver/downloads/list">chrome driver</a>
* Add it to your <a href="https://splinter.readthedocs.org/en/0.1/setup-chrome.html">system path</a>