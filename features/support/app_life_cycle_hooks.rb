require 'calabash-android/management/adb'
require 'calabash-android/operations'

Platform.use(ENV['MUT'])

Before do |scenario|
	Platform.reset_env

 #start_test_server_in_background
end

After do |scenario|
	Platform.after_scenario(scenario)

  # if scenario.failed?
  #   screenshot_embed
  # end
  # shutdown_test_server
end