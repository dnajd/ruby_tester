require 'log4r'
include Log4r
require 'log4r/configurator'
require 'log4r/outputter/udpoutputter'
 
####################################
# Class: Log Helper
# manual: http://log4r.rubyforge.org/manual.html
# formatter: http://log4r.sourceforge.net/rdoc/files/log4r/formatter/patternformatter_rb.html
# example: http://programmingstuff.wikidot.com/log4r
####################################
class LogHelper

	def initialize()
   	end

	def get_logger()

		# make directory
		Dir.mkdir("spec/logs") unless File.directory? "spec/logs"

		# get logger
		return xml_configed_logger("FullLogger")
	end

	def xml_configed_logger(logger_name)

		# configure logging
		Configurator.load_xml_file('log4r_config.xml')
		logger = Logger[logger_name]
	
		return logger
	end

end