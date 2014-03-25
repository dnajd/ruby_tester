require "rubygems"
require "rspec"
require "selenium-webdriver"
require_relative "../../lib/log4r/log_helper"
require_relative "../../lib/selenium/selenium_helper"
require_relative "../helpers/web_helper"
require_relative "page_objects/template_page"

describe 'The thing I am testing' do
  before(:all) do
    @driver          = WebHelper.create_driver
    @logger          = LogHelper.new.get_logger
    @domain          = WebHelper.setup_domain
    @screenshot_path = WebHelper.setup_screenshots
  end

  before(:each) do
    # Navigate to form page
    @driver.navigate.to "#{@domain}/somePage.aspx"

    # Init page obj
    @subject_name_page = TemplatePage.new(@driver)
  end

  after(:all) do
    @driver.quit
  end

  context 'performs some action' do
    it 'with some specific thing' do
      # Fill out form
      @template_page.fill_out_step1_required_fields

      # Click submit button
      @template_page.click_submit

      # Confirm on payment page
      element = @template_page.get_header

      SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do
        element.text.downcase!.should include 'page header'
      end
    end
  end
end
