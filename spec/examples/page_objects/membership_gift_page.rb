require_relative '../../helpers/form_helper'

class MembershipGiftPage

  def initialize(driver)

    @driver      = driver

    # Init FormHelper
    @form_helper = FormHelper.new(@driver)

  end

  def fill_out_step1_optional_fields(args={})

    items = [
        { field_name: 'Salutation', value: 'Miss', index: 1 },
        { field_name: 'First Name', value: 'Test3', index: 1 },
        { field_name: 'Last Name', value: 'Testerson3', index: 1 },
        { field_name: 'Address 2', value: '321 Test St.', index: 0 },
        { field_name: 'Evening Phone', value: '0987654321', index: 0 },
        { field_name: 'E-mail address', value: 'wtlogs2@mbayaq.org', index: 0 },
        { field_name: 'Confirm e-mail', value: 'wtlogs2@mbayaq.org', index: 0 },
        { field_name: 'Address 2', value: '432 Test St.', index: 1 },
        { field_name: 'Evening Phone', value: '9876543210', index: 1 },
        { field_name: 'Comments', value: 'This is created via automated Selenium test.', index: 0 }
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

  def fill_out_step1_required_fields(args=[], member_level='500')

    # Send gift to needs to be handled properly at some point. currently hard coded, but should be able to activate by value
    items = [
        { field_name: 'Salutation', value: 'Mrs.', index: 0 },
        { field_name: 'First Name', value: 'Test2', index: 0 },
        { field_name: 'Last Name', value: 'Testerson2', index: 0 },
        { field_name: 'Address 1', value: '321 Test St.', index: 0 },
        { field_name: 'City', value: 'Testville2', index: 0 },
        { field_name: 'State', value: 'Alaska', index: 0 },
        { field_name: 'Zip', value: '54321', index: 0 },
        { field_name: 'Daytime Phone', value: '9876543210', index: 0 },
        { field_name: 'Salutation', value: 'Mr.', index: 2 },
        { field_name: 'First Name', value: 'Test', index: 2 },
        { field_name: 'Last Name', value: 'Testerson', index: 2 },
        { field_name: 'Address 1', value: '123 Test St.', index: 1 },
        { field_name: 'City', value: 'Testville', index: 1 },
        { field_name: 'State', value: 'California', index: 1 },
        { field_name: 'Zip', value: '12345', index: 1 },
        { field_name: 'Country', value: 'United Kingdom', index: 0 },
        { field_name: 'Country', value: 'United Kingdom', index: 1 },
        { field_name: 'Daytime Phone', value: '1234567890', index: 1 },
        { field_name: 'E-mail address', value: 'wtlogs@mbayaq.org', index: 1 },
        { field_name: 'Confirm e-mail', value: 'wtlogs@mbayaq.org', index: 1 }
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

    # Hack to click send gift to sender
    elements = @driver.find_elements(:css, 'div.step1 [class*="SendMembershipTo"] table.scfRadioButtonList label')
    elements[1].click

    send_member_level member_level.to_s
    @form_helper.set_fields_by_label items

  end

  # Only 1 optional field, so just fill out the whole form for simplicity
  def fill_out_step2_fields(args={})

    # Calculate month/year in the future to use in payment form
    next_month, year = (Date.today >> 1).strftime('%m/%Y').split('/')

    items = [
        { field_name: 'Credit Card Number', value: '4111111111111111', index: 0 },
        { field_name: 'Month', value: next_month.strip, index: 0 },
        { field_name: 'Year', value: year.strip, index: 0 },
        { field_name: 'CVV', value: '123', index: 0 },
        { field_name: 'First Name', value: 'Test', index: 3 }, # 3rd occurance of field is on step 2, first 2 are in step 1
        { field_name: 'Last Name', value: 'Testerson', index: 3 },
        { field_name: 'Address 1', value: '123 Test St.', index: 2 },
        { field_name: 'Address 2', value: '321 Test St.', index: 2 },
        { field_name: 'City', value: 'Testville', index: 2 },
        { field_name: 'Zip / Postal Code', value: '12345', index: 0 } # index 0 because 2nd occurance is named different from 1st
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

  def form_helper

    @form_helper

  end


  # Clicks
  def click_continue

    element = @driver.find_element(:css, 'div.scfForm button.continue')
    element.click

  end

  def click_submit

    element = @driver.find_element(:css, 'div.scfForm div.scfSubmitButtonBorder input[type="submit"]')
    element.click

  end


  # Checks
  def check_step2_form_visible

    element = @driver.find_element(:css, 'div.scfForm div.step2')

    element.displayed?

  end

  def check_step3_is_visible

    text = @driver.find_element(:css, 'div.content h2').text.downcase
    text.include? 'thank you'

  end

  def check_validation_message_exists(error_message)

    messages = get_validation_summary.find_elements(:tag_name, 'li')

    messages.each do |message|
      if message.text.to_s.downcase.include? error_message.to_s.downcase
        return true
      end

    end

    return false

  end


  # Gets
  def get_member_level_value

    radio_buttons = @driver.find_elements(:css, 'div.membership-level input[type="radio"]')

    radio_buttons.each do |radio_button|
      if radio_button.selected?
        return radio_button.attribute('value')
      end

    end

    return nil

  end

  def get_step2_payment_amount

    @driver.find_element(:css, 'div.step2 span.total-amount').text

  end

  def get_step3_amount_value

    elements = @driver.find_element(:class, 'content').find_element(:tag_name, 'ul').find_elements(:tag_name, 'li')
    elements[2].text.gsub('Amount:', '').gsub('$', '').strip

  end

  def get_step3_recipient_name_value

    elements = @driver.find_element(:class, 'content').find_element(:tag_name, 'ul').find_elements(:tag_name, 'li')
    elements[0].text.gsub('Recipient Name:', '').strip

  end

  def get_step3_giver_name_value

    elements = @driver.find_element(:class, 'content').find_element(:tag_name, 'ul').find_elements(:tag_name, 'li')
    elements[1].text.gsub('Gift Giver Name:', '').strip

  end

  def get_step3_transaction_id_value

    elements = @driver.find_element(:class, 'content').find_element(:tag_name, 'ul').find_elements(:tag_name, 'li')
    elements[3].text.gsub('Transaction ID:', '').strip

  end

  def get_validation_summary

    @driver.find_element(:class, 'scfValidationSummary')

  end


  # Sends
  def send_member_level(value)

    # first find the element for the table, then grab each of the labels
    labels = @driver.find_elements(:css, 'div.membership-level label')

    # loop through the labels
    labels.each do |label|
      # set the value of radio to the label's name via it's for attribute
      radio = @driver.find_element(:id, label.attribute('for'))

      # check the value against the value inputted in the test
      if radio.attribute('value').to_i == value.to_i
        label.click

        return true
      end

    end

    return false

  end

end
