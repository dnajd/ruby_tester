class TemplatePage

  def initialize(driver)
    @driver = driver

    if (not @driver.title.include? 'Title of the page')
      raise 'Web driver is not on the correct page.'
    end
  end

=begin
  def fill_out_step1_required_fields(args=[])

    items = [
        { field_name: 'SomeField', value: '123 Test', index: 0 },
        { field_name: 'AnotherField', value: '456 Test', index: 0 }
    ]

    args.each do |arg|
      if arg[:index].nil?
        index = 0
      else
        index = arg[:index]
      end

      # Delete from items array if passed in combo of field_name and index is found
      items.delete_if { |item| item[:field_name] == arg[:field_name] && item[:index] == index }
      # Add passed in values back into the items array
      items.push field_name: arg[:field_name], value: arg[:value], index: index

    end

    @form_helper.set_fields_by_label items

  end
=end


  # Clicks
=begin
  def click_submit()
    element = @driver.find_element(:name, 'btnSubmit')
    element.click
  end
=end


  # Checks
=begin
  def check_hidden_message_is_visible()
    attribute = get_element.attribute('style').to_s
    attribute.include? "display: inline"
  end

  def check_validation_flash_exists()
    begin
      @driver.find_element(:id, 'lErrorMsg')
      return true
    rescue
      return false
    end
  end
=end


  # Gets
=begin
  def get_element
    @driver.find_element(:id, 'contactInfoCtrl_emailCtrl_cvCompEmail')
  end

  def get_element_value()
    @driver.find_elements(:name, 'memberLevelCtrl$rbMemberLevel')[1].attribute('value')
  end
=end


  # Sends
=begin
  def send_attribute(value)
    element = @driver.find_element(:name, 'contactInfoCtrl$tbAddress1')
    element.clear
    element.send_keys value
  end

  def send_radio_button_by_value(value)
    elements = @driver.find_elements(:name, 'rbChildOrGrandchild')
    elements.each do |element|
      if element.attribute('value') == value
        element.click
      end
    end
  end

  def send_radio_button_by_position(value)
    element = @driver.find_element(:name, 'contactInfoCtrl$ddlCountry')[value]
    element.click
  end

  def send_select_by_value(value)
    element = @driver.find_element(:name, 'contactInfoCtrl$ddlCountry')
    select  = Selenium::WebDriver::Support::Select.new(element)

    select.select_by(:text, value)
  end

  def send_select_by_position(value)
    element = @driver.find_element(:name, 'contactInfoCtrl$ddlCountry').find_elements(:tag_name, 'option')[value]
    element.click
  end
=end
end
