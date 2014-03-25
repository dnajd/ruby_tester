class FormHelper

  def initialize(driver)

    @driver = driver

    @form_labels = Array.new

    # TODO: possibly use XPath to get label by text
    labels       = driver.find_elements(:css, '.scfForm label')

    labels.each do |label|

      # some labels are hidden until form 2, and we can't get label text normally. detect and use alternate method when needed
      if label.text.empty?

        label_text = label.attribute('innerHTML')

      else

        label_text = label.text

      end

      @form_labels.push(
          label_text: label_text,
          label_id:   label.attribute('id'),
          label_for:  label.attribute('for'),
          label_type: label.attribute('type').to_s.downcase
      )

    end

  end

  def form_labels

  @form_labels

  end

  # Get field element
  def get_field_by_label(field_name, index = 0)

    # Filter by label text and match on index
    counter = 0

    @form_labels.each do |label|

      if label[:label_text] === field_name

        if index == counter

          input = @driver.find_element(:id, label[:label_for])

          return input

        end

        counter += 1

      end

    end

    # No matches
    raise "Field not found: #{field_name}"

  end

  # Set a field's value
  def set_field_by_label(field_name, value, index = 0)

    element = get_field_by_label(field_name, index)

    field_type = element.attribute('type').downcase

    # Set value based on type
    if (field_type=='text' || field_type=='textarea' || field_type=='tel' || field_type=='email')

      element.clear
      element.send_keys value

    elsif field_type.include? 'select'

      element = Selenium::WebDriver::Support::Select.new(element)
      element.select_by(:text, value)

    else

      raise "Field type unexpected: #{field_type}"

    end

    true

  end

  # Flip through array, and call set_field_by_value
  def set_fields_by_label(item_list)

    if item_list.kind_of?(Array)

      item_list.each do |item|
        set_field_by_label(item[:field_name], item[:value], item[:index])
      end

      true

    else

      raise 'Passed in argument must be an array.'

    end

  end

end
