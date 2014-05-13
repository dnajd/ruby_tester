require "rest_client"
require "json"
require 'minitest/autorun'
require_relative "../lib/log4r/log_helper"


class RestClientTest < MiniTest::Test

  def setup
  
  end

  def test_get_weather

    logger = LogHelper.new.get_logger

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