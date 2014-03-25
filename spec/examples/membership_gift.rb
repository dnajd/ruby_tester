require 'rubygems'
require 'rspec'
require 'selenium-webdriver'
require_relative '../../lib/log4r/log_helper'
require_relative '../../lib/selenium/selenium_helper'
require_relative '../helpers/web_helper'
require_relative '../helpers/form_helper'
require_relative 'page_objects/membership_gift_page'

describe 'Give a gift membership' do

  before(:all) do

    @driver          = WebHelper.create_driver
    @logger          = LogHelper.new.get_logger
    @domain          = WebHelper.setup_domain
    @screenshot_path = WebHelper.setup_screenshots

  end

  before(:each) do

    # Navigate to form page
    @driver.navigate.to "#{@domain}/support-us/membership/gift-membership"

    # Allow the driver to close the window without completing form
    @driver.execute_script('window.onbeforeunload = function(e){};')

    # Init page obj
    @membership_gift_page = MembershipGiftPage.new(@driver)

    # Init form helper
    @form_helper          = @membership_gift_page.form_helper

  end

  after(:all) do

    @driver.quit

  end

  context 'User info form' do

    context 'Continues to payment info form' do

      it 'with required fields' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          @membership_gift_page.check_step2_form_visible.should be true

        end

      end

      it 'with required and optional fields' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields
        @membership_gift_page.fill_out_step1_optional_fields

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          @membership_gift_page.check_step2_form_visible.should be true

        end

      end

    end

    context 'Fails to validate' do

      it 'with missing recipient salutation 1' do

        @membership_gift_page.fill_out_step1_required_fields [field_name: 'Salutation', value: '']

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('Member Salutation must be filled out').should be true

        end

      end

      it 'with missing recipient first name 1' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields [field_name: 'First Name', value: '']

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('Member First Name must be filled out').should be true

        end

      end

      it 'with missing recipient last name 1' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields [field_name: 'Last Name', value: '']

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('Member Last Name must be filled out').should be true

        end

      end

      it 'with missing recipient address 1' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields [field_name: 'Address 1', value: '']

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('Address 1 must be filled out').should be true

        end

      end

      it 'with missing recipient city' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields [field_name: 'City', value: '']

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do
          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('City must be filled out').should be true

        end

      end

      it 'with missing recipient state' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields [field_name: 'State', value: '']

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do
          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('State must be filled out').should be true

        end

      end

      it 'with missing recipient zip code' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields [field_name: 'Zip', value: '']

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do
          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('Zip must be filled out').should be true

        end

      end

      it 'with missing recipient day phone' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields [field_name: 'Daytime Phone', value: '']

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('Daytime Phone must be filled out').should be true

        end

      end

      it 'with missing recipient email confirmation' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields [{
                                                                  field_name: 'Confirm e-mail', value: '',
                                                                  field_name: 'E-mail address', value: 'test@test.com'
                                                              }]

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('The E-mail address and Confirm e-mail fields must be the same').should be true

        end

      end

      it 'when recipient email and email confirmation do not match' do

        # Fill out form
        args = [{ field_name: 'E-mail address', value: 'test@test.com' }, { field_name: 'Confirm e-mail', value: 'wrong@test.com' }]
        @membership_gift_page.fill_out_step1_required_fields args

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('The E-mail address and Confirm e-mail fields must be the same').should be true

        end

      end

      it 'with missing giver salutation' do

        @membership_gift_page.fill_out_step1_required_fields [field_name: 'Salutation', value: '', index: 2]

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('Giver Salutation must be filled out').should be true

        end

      end

      it 'with missing giver first name' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields [field_name: 'First Name', value: '', index: 2]

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('Giver First Name must be filled out').should be true

        end

      end

      it 'with missing giver last name' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields [field_name: 'Last Name', value: '', index: 2]

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('Giver Last Name must be filled out').should be true

        end

      end

      it 'with missing giver address 1' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields [field_name: 'Address 1', value: '', index: 1]

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('Address 1 must be filled out').should be true

        end

      end

      it 'with missing giver city' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields [field_name: 'City', value: '', index: 1]

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do
          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('City must be filled out').should be true

        end

      end

      it 'with missing giver state' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields [field_name: 'State', value: '', index: 1]

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do
          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('State must be filled out').should be true

        end

      end

      it 'with missing giver zip code' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields [field_name: 'Zip', value: '', index: 1]

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do
          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('Zip must be filled out').should be true

        end

      end

      it 'with missing giver day phone' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields [field_name: 'Daytime Phone', value: '', index: 1]

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('Daytime Phone must be filled out').should be true

        end

      end

      it 'with missing giver email' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields [field_name: 'E-mail address', value: '', index: 1]

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('E-mail address must be filled out').should be true

        end

      end

      it 'with missing giver email confirmation' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields [field_name: 'Confirm e-mail', value: '', index: 1]

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('Confirm e-mail must be filled out').should be true

        end

      end

      it 'when giver email and email confirmation do not match' do

        # Fill out form
        args = [
            { field_name: 'E-mail address', value: 'test@test.com', index: 1 },
            { field_name: 'Confirm e-mail', value: 'wrong@test.com', index: 1 }
        ]
        @membership_gift_page.fill_out_step1_required_fields args

        # Click submit button
        @membership_gift_page.click_continue

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 1

          @membership_gift_page.check_step2_form_visible.should be false
          @membership_gift_page.check_validation_message_exists('The E-mail address and Confirm e-mail fields must be the same').should be true

        end

      end

    end

  end

  context 'Payment info form' do
    it 'provided values should match values from user info form' do

      # Fill out form
      @membership_gift_page.fill_out_step1_required_fields

      # Capture field values
      name_first = @form_helper.get_field_by_label('First Name', 2).attribute('value')
      name_last  = @form_helper.get_field_by_label('Last Name', 2).attribute('value')
      address_1  = @form_helper.get_field_by_label('Address 1', 1).attribute('value')
      city       = @form_helper.get_field_by_label('City', 1).attribute('value')
      zip        = @form_helper.get_field_by_label('Zip', 1).attribute('value')

      # Click submit button
      @membership_gift_page.click_continue

      SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

        (@form_helper.get_field_by_label 'First Name', 3).attribute('value').should eq name_first
        (@form_helper.get_field_by_label 'Last Name', 3).attribute('value').should eq name_last
        (@form_helper.get_field_by_label 'Address 1', 2).attribute('value').should eq address_1
        (@form_helper.get_field_by_label 'City', 2).attribute('value').should eq city
        (@form_helper.get_field_by_label 'Zip / Postal Code').attribute('value').should eq zip

      end

    end

    it 'continues to confirmation page with required fields' do

      # Fill out step1 form
      @membership_gift_page.fill_out_step1_required_fields

      # Click continue button
      @membership_gift_page.click_continue

      # let the page setup
      sleep 1

      # Fill out step 2 form
      @membership_gift_page.fill_out_step2_fields

      # Click submit button
      @membership_gift_page.click_submit

      SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

        @membership_gift_page.check_step3_is_visible.should be true

      end

    end

    it 'has correct pay amount' do

      # Fill out form
      @membership_gift_page.fill_out_step1_required_fields [], 275

      # Click submit button
      @membership_gift_page.click_continue

      # Get listed payment amount
      payment_amount = @membership_gift_page.get_step2_payment_amount

      SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

        (payment_amount.to_f.round(2)).should eql (275).to_f.round(2)

      end

    end

    context 'Fails to validate' do

      it 'with invalid card number' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields

        # Click submit button
        @membership_gift_page.click_continue

        # Fill out payment form
        @membership_gift_page.fill_out_step2_fields [field_name: 'Credit Card Number', value: '4']

        # Click submit button
        @membership_gift_page.click_submit

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 0.2

          @membership_gift_page.check_step2_form_visible.should be true
          @membership_gift_page.check_validation_message_exists('The value of the Credit Card Number field is not valid').should be true

        end

      end

      it 'with missing card number' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields

        # Click submit button
        @membership_gift_page.click_continue

        # Fill out payment form
        @membership_gift_page.fill_out_step2_fields [field_name: 'Credit Card Number', value: '']

        # Click submit button
        @membership_gift_page.click_submit

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 0.2

          @membership_gift_page.check_step2_form_visible.should be true
          @membership_gift_page.check_validation_message_exists('Credit Card Number must be filled in').should be true

        end

      end

      it 'with missing cvv number' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields

        # Click submit button
        @membership_gift_page.click_continue

        # Fill out payment form
        @membership_gift_page.fill_out_step2_fields [field_name: 'CVV', value: '']

        # Click submit button
        @membership_gift_page.click_submit

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 0.2

          @membership_gift_page.check_step2_form_visible.should be true
          @membership_gift_page.check_validation_message_exists('CVV must be filled in').should be true

        end

      end

      it 'with missing first name' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields

        # Click submit button
        @membership_gift_page.click_continue

        # Fill out payment form
        @membership_gift_page.fill_out_step2_fields [field_name: 'First Name', value: '', index: 3]

        # Click submit button
        @membership_gift_page.click_submit

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 0.2

          @membership_gift_page.check_step2_form_visible.should be true
          @membership_gift_page.check_validation_message_exists('Billing First Name must be filled in').should be true

        end

      end

      it 'with missing last name' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields

        # Click submit button
        @membership_gift_page.click_continue

        # Fill out payment form
        @membership_gift_page.fill_out_step2_fields [field_name: 'Last Name', value: '', index: 3]

        # Click submit button
        @membership_gift_page.click_submit

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 0.2

          @membership_gift_page.check_step2_form_visible.should be true
          @membership_gift_page.check_validation_message_exists('Billing Last Name must be filled in').should be true

        end

      end

      it 'with missing address 1' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields

        # Click submit button
        @membership_gift_page.click_continue

        # Fill out payment form
        @membership_gift_page.fill_out_step2_fields [field_name: 'Address 1', value: '', index: 2]

        # Click submit button
        @membership_gift_page.click_submit

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 0.2

          @membership_gift_page.check_step2_form_visible.should be true
          @membership_gift_page.check_validation_message_exists('Billing Address 1 must be filled in').should be true

        end

      end

      it 'with missing city' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields

        # Click submit button
        @membership_gift_page.click_continue

        # Fill out payment form
        @membership_gift_page.fill_out_step2_fields [field_name: 'City', value: '', index: 2]

        # Click submit button
        @membership_gift_page.click_submit

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 0.2

          @membership_gift_page.check_step2_form_visible.should be true
          @membership_gift_page.check_validation_message_exists('Billing City must be filled in').should be true

        end

      end

      it 'with missing zip' do

        # Fill out form
        @membership_gift_page.fill_out_step1_required_fields

        # Click submit button
        @membership_gift_page.click_continue

        # Fill out payment form
        @membership_gift_page.fill_out_step2_fields [field_name: 'Zip / Postal Code', value: '']

        # Click submit button
        @membership_gift_page.click_submit

        SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

          sleep 0.2

          @membership_gift_page.check_step2_form_visible.should be true
          @membership_gift_page.check_validation_message_exists('Billing Zip must be filled in').should be true

        end

      end

    end

  end

  context 'Confirmation page' do

    it 'displays the correct information' do

      # Fill out form
      @membership_gift_page.fill_out_step1_required_fields [], 275

      # Click submit button
      @membership_gift_page.click_continue

      # Fill out payment form
      @membership_gift_page.fill_out_step2_fields

      # Click submit button
      @membership_gift_page.click_submit

      SeleniumHelper.screen_grab_error(@driver, "#{@screenshot_path}#{example.metadata[:full_description]}") do

        sleep 1
        @membership_gift_page.check_step3_is_visible.should be true
        @membership_gift_page.get_step3_recipient_name_value.should eq 'Test2 Testerson2'
        @membership_gift_page.get_step3_giver_name_value.should eq 'Test Testerson'
        @membership_gift_page.get_step3_amount_value.to_f.should eq 275
        @membership_gift_page.get_step3_transaction_id_value.length.should > 2

      end

    end

  end

end
