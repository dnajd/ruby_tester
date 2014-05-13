################################################
# Rest client: https://github.com/rest-client/rest-client
# Debugging Rest Data:
#    - save to file: File.open("test/logs/inspect.json","w") {|f| f.write(JSON.pretty_generate(json_obj))}
#    - puts to console: puts JSON.pretty_generate(json_obj)
################################################

require "rest_client"
require 'minitest/autorun'
require "json"
require_relative "../../lib/log4r/log_helper"

class RestClientTest < MiniTest::Test

  def setup
    @logger = LogHelper.new.get_logger
  end

  def test_get_weather

    @logger.info "test"

    # rest uri
    uri = 'http://api.openweathermap.org/data/2.5/weather?q=Santa%20Rosa,CA'
    
    # try api call
    response = RestClient.get uri, {:accept => :json}
    assert_equal 200, response.code
    
    # json obj
    json_obj = JSON.parse(response)
    assert_equal 'Santa Rosa', json_obj["name"]

  end

  
end