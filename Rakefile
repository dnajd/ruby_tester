# Rakefile tutorial: http://jasonseifer.com/2010/04/06/rake-tutorial
require 'rake'
require 'irb'
require 'fileutils'
require 'rake/testtask'
require 'ci/reporter/rake/minitest' # From: https://github.com/nicksieger/ci_reporter

desc "setup for ci reporter"
task :setup do
  ci_reports_file = ENV['CI_REPORTS'] = "./test/reports"
  puts "Ci reports are here:" + ci_reports_file

  # folders
  Dir.mkdir("test/logs") unless File.directory? "test/logs"
  Dir.mkdir("test/reports") unless File.directory? "test/reports"
end


desc "clean out reports and logs"
task :clean do
  Dir.mkdir("test/reports") unless File.directory? "test/reports"
  Dir.mkdir("test/logs") unless File.directory? "test/logs"
end


desc 'Unit tests.'
Rake::TestTask.new(:test => ['ci:setup:minitest', 'setup']) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.warning = false
end


desc "interactive irb for testing"
task :default do
  exec("irb -r ./lib/irb/bootstrap_irb.rb")
end
