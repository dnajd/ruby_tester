################################################
# RSpec with rest-client
#
# Rspec Matchers: http://rspec.rubyforge.org/rspec/1.1.9/classes/Spec/Matchers.html
# Rest client: https://github.com/rest-client/rest-client
# Debugging Rest Data:
#    - save to file: File.open("spec/logs/inspect.json","w") {|f| f.write(JSON.pretty_generate(json_obj))}
#    - puts to console: puts JSON.pretty_generate(json_obj)
################################################

require "rubygems"
require "rspec"
require "rest_client"
require "json"
require_relative "../../lib/log4r/log_helper"

describe "weather" do
 
  # selenium web driver
  before(:all) do
    @logger = LogHelper.new.get_logger
  end
  
  it "should get weather" do

    # rest uri
    uri = 'http://api.openweathermap.org/data/2.5/weather?q=Santa%20Rosa,CA'
    
    # try api call
    response = RestClient.get uri, {:accept => :json}
    response.code.should eql(200)
    
    # json obj
    json_obj = JSON.parse(response)
    json_obj["name"].should eql('Santa Rosa')

  end
 
  # ensure that the browser is shutdown 
  after(:all) do
 
  end
end