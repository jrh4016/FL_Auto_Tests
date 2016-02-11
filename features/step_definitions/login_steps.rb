##
# In our steps, we should rely heavily on our operations module to do the heavy lifting.
# The set definitions should be nice and short, so if we need to fill in a form, or press
# a few buttons in a row to perform a single action, then these should all be in an operations function
# Data generation (see customer_steps.rb), data retrival (customer steps again), operational steps
# and assertions should always be performed here.
Given(/^I login$/) do
	NavigationOperations.connect_beta_server
	LoginOperations.login(TestConfig.username)
  if ENV['USER'] == 'dtoretto'
    Faker::Config.locale = 'en'
  elsif ENV['USER'] == 'sspiegel'
    Faker::Config.locale = 'en-ca'
  end
end