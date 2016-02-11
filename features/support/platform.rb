require_relative "./env.rb"
##
# Platform will look after set up/tear down of platform specific steps
# We can also determine which platform we are using at any time, so that
# other steps can execute the correct code
module Platform
  extend Calabash::Android::Operations
  class << self

    attr_accessor :calabash_launcher

    ##
    # platform  - web | mobile
    # this will also set up the platform the first time it is run
    def use(platform)
      set_mobile_platform(platform)
      setup_env 
    end

    def set_mobile_platform(mobile_platform)
      case mobile_platform
      when 'IOS'
        @platform = :ios
      when 'AND'
        @platform = :android
      else
        raise "mobile platform - env var 'MUT' has not being set. valid values are: 'IOS', 'AND'"
      end
    end

    def android?; :android == @platform; end

    def ios?; :ios == @platform; end

    def setup_env
      setup_android if android?
      setup_ios if ios?
    end

    def reset_env
      reset_android if android?
      reset_ios if ios?
    end

    ##
    # we need to close everything here, so that we can run tests multiple
    # times and not leave anything open afterwards
    def close_all
      close_android if android?
      close_ios     if ios?
    end
		

    def setup_android
      #Log.instance.debug("#{__FILE__}:#{__LINE__} setting up android")
      #uninstall_apps
      #Log.instance.debug("#{__FILE__}:#{__LINE__} - test app path: ENV['TEST_APP_PATH']")
      #Log.instance.debug("#{__FILE__}:#{__LINE__} - app_path: ENV['APP_PATH']")
      #install_app(ENV["TEST_APP_PATH"])
      #install_app(ENV["APP_PATH"])
    end


    def reset_android()
      #Log.instance.debug("#{__FILE__}:#{__LINE__} resetting android")
      if(ENV['RESET_BETWEEN_SCENARIOS'] == "1")
      	  clear_app_data
	  end
      start_test_server_in_background
    end

    def close_android
    end

    def setup_ios
      #Log.instance.debug("#{__FILE__}:#{__LINE__} setting up ios")
    end

    def reset_ios
      #Log.instance.debug("#{__FILE__}:#{__LINE__} resetting ios")
      #clear_ios_data
      @calabash_launcher = Calabash::Cucumber::Launcher.new
      unless @calabash_launcher.calabash_no_launch?
        @calabash_launcher.relaunch
        @calabash_launcher.calabash_notify(self)
      end
      #start_test_server_in_background
    end

    def close_ios
      Log.instance.debug("#{__FILE__}:#{__LINE__} closing ios")
      launcher = Calabash::Cucumber::Launcher.new
      if launcher.simulator_target?
        Calabash::Cucumber::SimulatorHelper.stop unless launcher.calabash_no_stop?
      end
    end

    ##
    # we can determine what to do for each platform after a secneario.
    # use the after_scenario cucumber hook to call this method
    def after_scenario(scenario)
      #Log.debug "#{__FILE__}:#{__LINE__} - @mobile_scenario_reset #{@mobile_scenario_reset}"
      #Log.debug "--------------------------------------------- PASS -----------------------------------------------------"
      if android?
        screenshot_embed if scenario.failed?
      end
    end

    def clear_ios_data
      app_dir = '~/Library/Application\ Support/iPhone\ Simulator/' + TestConfig.sdk_version_passed + '/Applications'
      app = File.basename(TestConfig.app_bundle_path)
      bundle = `find #{app_dir} -type d -depth 2 -name #{app}`
      sandbox = File.dirname(bundle)
      Log.debug("#{__FILE__}:#{__LINE__} - sandbox dir: #{sandbox}")
      ['Library', 'Documents', 'tmp'].each do |dir|
        FileUtils.rm_rf(File.join(sandbox, dir))
      end
    end

  end
end