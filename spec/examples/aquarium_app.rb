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
require_relative "../../spec/helpers/rest_helper"
require_relative "../../lib/log4r/log_helper"

describe 'Aquarium App "API"' do

  before(:all) do

    # Setup domain
    @domain    = RestHelper.setup_aqapp_domain
    #@logger = LogHelper.new.get_logger

    # Setup json objects and responses
    this_day   = Date.today.strftime('%Y-%m-%d')
    this_month = Date.today.strftime('%Y-%m')

    @exhibits_response       = RestClient.get "#{@domain}/exhibits", { :accept => :json }
    @exhibits_json           = JSON.parse(@exhibits_response)
    @schedule_day_response   = RestClient.get "#{@domain}/schedule/day/#{this_day}", { :accept => :json }
    @schedule_day_json       = JSON.parse(@schedule_day_response)
    @special_events_response = RestClient.get "#{@domain}/schedule/month/#{this_month}/specialevents", { :accept => :json }
    @special_events_json     = JSON.parse(@special_events_response)
    @postcard_response = RestClient.get "#{@domain}/postcards/images", { :accept => :json }
    @postcard_json     = JSON.parse(@postcard_response)
    @programs_response = RestClient.get "#{@domain}/programs", { :accept => :json }
    @programs_json     = JSON.parse(@programs_response)

  end

  context 'Exhibits path' do

    it "should respond with code 200" do

      @exhibits_response.code.should eql(200)

    end

    it "should contain at least 1 exhibit" do

      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        @exhibits_json["Exhibits"].count.should be > 0
      end

    end

    it "should provide an auditorium image URL" do

      uri = URI (@exhibits_json["AuditoriumImage"])

      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        uri.host.should_not be nil
      end

    end

    it "should provide valid data for each exhibit" do

      @exhibits_json['Exhibits'].each do |exhibit|
        facebook_uri = URI (exhibit['FacebookId'])
        image_uri    = URI (exhibit['Image'])

        RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
          exhibit['ExhibitId'].to_s.empty?.should be false
          facebook_uri.host.should_not be nil
          image_uri.host.should_not be nil
          exhibit['Name'].length.should be > 0
        end

      end

    end

  end

  context 'Exhibit detail path' do

    before(:all) do

      exhibit = @exhibits_json['Exhibits'].sample

      @exhibit_response = RestClient.get "#{@domain}/exhibits/#{exhibit['ExhibitId']}", { :accept => :json }
      @exhibit_json     = JSON.parse(@exhibit_response)

    end

    it "should respond with code 200" do

      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        @exhibit_response.code.should eql(200)
      end

    end

    it "should have at least 1 asset" do

      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        @exhibit_json['Assets'].count.should be > 0
      end

    end

    it "should provide valid data for each asset" do

      @exhibit_json['Assets'].each do |asset|
        image_uri = URI (asset['Image'])

        RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
          asset['AssetId'].to_i.should be > 0
          asset['Description'].length.should be > 0
          image_uri.host.should_not be nil
          asset['Name'].length.should be > 0
        end
      end

    end

    it "should have a description" do

      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        @exhibit_json['Description'].length.should be > 0
      end

    end

    it "should have feeding times defined" do

      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        (@exhibit_json.include? 'FeedingTimes').should be true
      end

    end

    it "should provide valid data for feeding times" do

      # Feeding times aren't always provided, so check first
      if (@exhibit_json['FeedingTimes'].count > 0)
        @exhibit_json['FeedingTimes'].each do |feeding_time|
          start_time = DateTime.strptime feeding_time['StartTime']
          end_time   = DateTime.strptime feeding_time['EndTime']

          RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
            (feeding_time['Id'].to_i).should be > 0
            start_time.should be_kind_of DateTime
            end_time.should be_kind_of DateTime
          end
        end
      end

    end

    it "should have a valid Facebook id" do

      uri = URI (@exhibit_json['FacebookId'])

      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        uri.host.should_not be nil
      end

    end

    it "should have a name" do

      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        @exhibit_json['Name'].length.should be > 0
      end

    end

    it "should have related items defined" do

      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        (@exhibit_json.include? 'RelatedItems').should be true
      end

    end

    it "should provide valid data for related items" do

      # Related items aren't always provided, so check first
      if (@exhibit_json['RelatedItems'].count > 0)
        @exhibit_json['RelatedItems'].each do |related_item|
          image_uri = URI (related_item['Image'])

          RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
            related_item['AssetId'].empty?.should be false
            related_item['Description'].length.should be > 0
            # Because auditorium related items get id of 0, just test that the id has some value
            related_item['ExhibitId'].empty?.should be false
            image_uri.host.should_not be nil
            related_item['Teaser'].length.should be > 0
          end
        end
      end

    end

  end

  context 'Day schedule path' do
    it "should respond with code 200" do
      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        @schedule_day_response.code.should eql(200)
      end
    end

    it "should have a valid date" do
      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        (DateTime.strptime @schedule_day_json['Date']).should be_kind_of DateTime
      end
    end

    it "should have valid operating hours" do
      # Handle aquarium closed on xmas
      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        if (Date.today.strftime('%m-%d') == "12-25")
          (@schedule_day_json['GeneralOpeningTime'].downcase.include? "closed").should be true
          (@schedule_day_json['GeneralClosingTime'].downcase.include? "closed").should be true
          (@schedule_day_json['MemberOpeningTime'].downcase.include? "closed").should be true
          (@schedule_day_json['MemberClosingTime'].downcase.include? "closed").should be true
        else
          (DateTime.strptime @schedule_day_json['GeneralOpeningTime']).should be_kind_of DateTime
          (DateTime.strptime @schedule_day_json['GeneralClosingTime']).should be_kind_of DateTime
          (DateTime.strptime @schedule_day_json['MemberOpeningTime']).should be_kind_of DateTime
          (DateTime.strptime @schedule_day_json['MemberClosingTime']).should be_kind_of DateTime
        end
      end
    end

    it "should have valid data for each event" do
      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        if (Date.today.strftime('%m-%d') == "12-25")
          (@schedule_day_json.include? 'Events').should be true
          (@schedule_day_json.include? 'SpecialEvents').should be true
        else
          @schedule_day_json['Events'].count.should be > 0

          @schedule_day_json['Events'].each do |event|
            event['Id'].to_s.empty?.should be false
            (DateTime.strptime event['Time']).should be_kind_of DateTime
            event['Name'].to_s.length.should be > 0
          end
        end
      end
    end
  end

  context "Month schedule path" do
    it "should respond with code 200" do
      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        @special_events_response.code.should eql(200)
      end
    end

    it "should have a valid Month" do
      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        (DateTime.strptime @special_events_json['Month']).should be_kind_of DateTime
      end
    end

    it "should have special events defined" do
      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        (@special_events_json.include? 'SpecialEvents').should be true
      end
    end

    it "should have valid data for each special event" do
      if (@special_events_json['SpecialEvents'].count > 0)
        @special_events_json['SpecialEvents'].each do |event|
          RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
            (DateTime.strptime event['Date']).should be_kind_of DateTime
          end
        end
      end
    end
  end

  context "Postcards path" do
    it "should respond with code 200" do
      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        @postcard_response.code.should eql(200)
      end
    end

    it "should have at least 1 image" do
      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        @postcard_json['Images'].count.should be > 0
      end
    end

    it "should have valid data for each image" do
      @postcard_json['Images'].each do |image|
        uri = URI (image["ImageUrl"])

        RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
          (image['PostCardId'].empty?).should be false
          uri.host.should_not be nil
          image['Caption'].to_s.length.should be > 0
        end
      end
    end
  end

  context 'Programs path' do
    it "should respond with code 200" do
      RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
        @programs_response.code.should eql(200)
      end
    end

    it "should have valid data for each program" do
      @programs_json['Programs'].each do |program|
        image_uri = URI (program['Image'])

        RestHelper.write_json_to_log(@exhibits_json, "#{example.metadata[:full_description]}") do
          program['ProgramId'].to_i.should be > 0
          program['Name'].to_s.length.should be > 0
          image_uri.host.should_not be nil
          program['Location'].to_s.length.should be > 0
          program['Duration'].to_i.should be > 0
          program['Description'].to_s.length.should be > 0
          program['Times'].count.should be > 0

          program['Times'].each do |program_time|
            (DateTime.strptime program_time['Time']).should be_kind_of DateTime
          end
        end
      end
    end
  end
end

