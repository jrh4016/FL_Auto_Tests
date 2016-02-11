

module TestConfig
  class << self

    def username
      ENV['USER'] ? ENV['USER'] : raise("env var USER not set")
    end

    def app_bundle_path
      ENV['APP_BUNDLE_PATH'] ? ENV['APP_BUNDLE_PATH'] : raise("env var APP_BUNDLE_PATH not set")

    end

    def server_url
      if !ENV['SERVER_URL'].nil?
        ENV['SERVER_URL']
      elsif ENV['MUT'] == 'AND'
        #'https://qa2.fieldlocate.com/ws/'
        'http://192.168.0.186:8080/ws/'
      elsif ENV['MUT'] == 'IOS'
        'http://127.0.0.1:8080'
      end
    end

    #def sdk_version_passed
    #	ENV['SDK_VERSION_PASSED'] ? ENV['SDK_VERSION_PASSED'] : raise("set SDK_VERSION_PASSED, value to be taken from choice of \n
    #					ls -al ~/Library/Application\ Support/iPhone\ Simulator/")
    #end
  end
end