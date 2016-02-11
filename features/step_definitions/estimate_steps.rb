





Then(/^I create an estimate$/) do
	 EstimateOperations.create_estimate()
end

Then(/^I add a new custom line item and discount$/) do
	 EstimateOperations.add_custom()
end