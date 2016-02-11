Given /^I goto the "(.*?)" screen$/ do |screen|
	NavigationOperations.goto(screen)
end

Then(/I go back to the previous screen$/) do
  NavigationOperations.go_back
end