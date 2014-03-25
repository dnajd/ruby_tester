class WebHelper
  def self.create_driver(mode='desktop')
    driver = nil
    begin
      driver = Selenium::WebDriver.for :chrome, :switches => %w[ --disable-extensions
                                                                  --disable-prompt-on-repost
                                                                  --disable-sync
                                                                  --silent]
    rescue
      driver = Selenium::WebDriver.for :firefox
    end

    driver.manage.timeouts.implicit_wait = 10 # seconds

    # Set default mode to desktop
    setup_window driver

    return driver
  end

  def self.setup_domain
    domain = nil

    if ENV['DOMAIN']
      domain = ENV['DOMAIN']
    else
      domain = 'http://staging.mbayaq.org'
    end

    return domain
  end

  def self.setup_screenshots
    screenshot_path = nil

    if !ENV['CI_REPORTS'].nil?
      screenshot_path = "#{ENV['CI_REPORTS']}/"
    else
      screenshot_path = './spec/reports/screenshots/'

      FileUtils.rm_rf(screenshot_path)
    end

    FileUtils.mkdir_p(screenshot_path) unless File.directory? screenshot_path

    return screenshot_path
  end

  def self.setup_window(driver, mode='desktop')
    # Set screen size and position
    driver.manage.window.move_to(0, 0)

    case mode
      when 'mobile'
        driver.manage.window.resize_to(500, 800)

        sleep 1
      when 'tablet'
        driver.manage.window.resize_to(1000, 800)

        sleep 1
      when 'desktop'
        driver.manage.window.resize_to(1300, 800)
        driver.manage.window.maximize
      else
        raise "Window mode must be provided (desktop, tablet or mobile). Provided: #{mode}"
    end
  end
end
