# Rakefile tutorial: http://jasonseifer.com/2010/04/06/rake-tutorial
require 'rake'
require 'rspec/core/rake_task'
require 'ci/reporter/rake/rspec' # From: https://github.com/nicksieger/ci_reporter
require 'irb'

# SETUP & CLEANUP
task :setup do

  # ci reports
  ci_reports_file = ENV['CI_REPORTS'] = "./spec/reports"
  puts "ci reports are here:" + ci_reports_file

  # folders
  Dir.mkdir("spec/logs") unless File.directory? "spec/logs"
  Dir.mkdir("spec/reports") unless File.directory? "spec/reports"

end
task :clean do
  exec("rm -r -f ./spec/reports|rm -r -f ./spec/logs")
end

# EXAMPLES
RSpec::Core::RakeTask.new(:rspec_selenium => ["ci:setup:rspec"]) do |t|
  	t.pattern = 'spec/examples/rspec_selenium.rb'
end
RSpec::Core::RakeTask.new(:rspec_rest_client => ["ci:setup:rspec"]) do |t|
  	t.pattern = 'spec/examples/rspec_rest_client.rb'
end
RSpec::Core::RakeTask.new(:rspec_selenium_page_obj => ["ci:setup:rspec"]) do |t|
  	t.pattern = 'spec/examples/rspec_selenium_page_obj.rb'
end
RSpec::Core::RakeTask.new(:rspec_selenium_screen_shot => ["ci:setup:rspec"]) do |t|
  	t.pattern = 'spec/examples/rspec_selenium_screen_shot.rb'
end
task :examples => [:setup, :rspec_selenium_page_obj, :rspec_selenium, :rspec_rest_client, :rspec_selenium_screen_shot]


# DEFAULT
task :default do
	exec("irb -r ./lib/irb/bootstrap_irb.rb")
end

=begin Examples
task :api => [:rspec_api]
task :calendar => [:rspec_calendar]

# Setup tasks that should be called in top level
task :api_setup do
  FileUtils.rm_rf('./spec/reports/rspec_api')
  FileUtils.rm_f('./spec/logs/API_Log.txt')

  Dir.mkdir("spec/reports") unless File.directory? "spec/reports"
  Dir.mkdir("spec/logs") unless File.directory? "spec/logs"

  ENV['CI_REPORTS'] = "./spec/reports/rspec_api"
  puts '*** CI Reports are here: ' + ENV['CI_REPORTS'] + "\n"

  ENV['LOG_NAME'] = './spec/logs/API_Log.txt'
end

task :calendar_setup do
  FileUtils.rm_rf('./spec/reports/rspec_calendar')
  #FileUtils.rm_rf('spec/logs')

  Dir.mkdir("spec/reports") unless File.directory? "spec/reports"
  #Dir.mkdir("spec/logs") unless File.directory? "spec/logs"

  ENV['CI_REPORTS'] = "./spec/reports/rspec_calendar"
  puts '*** CI Reports are here: ' + ENV['CI_REPORTS'] + "\n"
end

# Low level individual tasks that top level calls
# API
RSpec::Core::RakeTask.new(:rspec_api => ["ci:setup:rspec", :api_setup]) do |t|
  t.pattern = 'spec/api/*.rb'
end

# Calendar
RSpec::Core::RakeTask.new(:rspec_calendar => ["ci:setup:rspec", :calendar_setup]) do |t|
  t.pattern = 'spec/calendar/*.rb'
end
=end
