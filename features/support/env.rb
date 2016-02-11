require "rubygems"
require "bundler"
require "calabash-android/cucumber" if ENV['MUT'] == 'AND'
require "calabash-cucumber/cucumber" if ENV['MUT'] == 'IOS'
require "debugger"
require "logger"
require "factory_girl"
require "securerandom"
require 'briar/cucumber'
require_relative "platform"
require_relative "test_config"


Dir[File.dirname(__FILE__) + "/../step_definitions/lib/*s/*.rb"].each do |file|
	#puts file
  require file
end

# set up logging var. usage: Log.debug("#{__FILE__}:#{__LINE__} - log message")
module Log
    class << self
      attr_accessor :instance
      def debug(log)
        #instance.debug(log)
      end
    end
end
Log.instance = Logger.new(STDOUT)

case ENV['MUT']
	when 'AND'
		include Android
	when 'IOS'
		#Log.debug("requiring ios")
		include IOS
  else
		raise "ENV['MUT'] should be set to either AND or IOS"
end

def main_activity(_)
	#"com.skeds.android.phone.business.Activities.Phone.ActivityDashboardView"
	#"com.skeds.android.phone.business.Activities.Phone.ActivityLoginMobile"
	"com.skeds.android.phone.business.activities.ActivityDashboardView"
end