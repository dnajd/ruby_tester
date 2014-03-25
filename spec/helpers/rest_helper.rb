class RestHelper
  def self.setup_aqapp_domain
    domain = nil

    if ENV['aqappapi_domain']
      domain = ENV['aqappapi_domain']
    else
      #domain = 'http://badri:SecretSauce@services.mbayaq.org/aqapp-api/v1'
      domain = 'http://badri:SecretSauce@staging.mbayaq.org/aqapp-api/v1'
    end

    return domain
  end

  def self.write_json_to_log(json_obj, test_name)
    begin
      yield
    rescue => error
      if (ENV['LOG_NAME'].nil?)
        filename = './spec/logs/testLog.txt'

        FileUtils.mkdir_p (File.dirname filename)
        FileUtils.rm_f filename
      else
        filename = ENV['LOG_NAME'].gsub(' ', '-')
      end

      f = File.new(filename, 'a')
      f.puts ''
      f.puts ''
      f.puts "--- Test: #{test_name}"
      f.puts JSON.pretty_generate(json_obj)
      f.close
      raise
    end
  end

end
