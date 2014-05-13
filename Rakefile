# Rakefile tutorial: http://jasonseifer.com/2010/04/06/rake-tutorial
require 'rake'
require 'irb'
require 'fileutils'

###############################
# minitest
require 'rake/testtask'

desc 'Unit tests.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.warning = false
end


###############################
# rspec
require 'rspec/core/rake_task'
require 'ci/reporter/rake/rspec' # From: https://github.com/nicksieger/ci_reporter

# SETUP & CLEANUP
task :setup do

  # ci reports
  ci_reports_file = ENV['CI_REPORTS'] = "./test/reports"
  puts "Ci reports are here:" + ci_reports_file

  # folders
  Dir.mkdir("test/logs") unless File.directory? "test/logs"
  Dir.mkdir("test/reports") unless File.directory? "test/reports"

end
task :clean do
  Dir.mkdir("test/reports") unless File.directory? "test/reports"
  Dir.mkdir("test/logs") unless File.directory? "test/logs"
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
