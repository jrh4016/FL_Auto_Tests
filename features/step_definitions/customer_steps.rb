

Then(/^I add a new customer "(.*?)"$/) do |customer|
  StepsDataCache.cache[customer] = DataOperations::Customer.new
  CustomerOperations.new_customer(StepsDataCache.cache[customer])
end

Then(/^I search for and open customer "(.*?)"$/) do |customer|
	if StepsDataCache.cache[customer].nil?
	  StepsDataCache.cache[customer] = DataOperations::Customer.new
    StepsDataCache.cache[customer].load_from_file
  end
	CustomerOperations.search(StepsDataCache.cache[customer])
end

Then(/^I add a phone number "(.*?)" for customer "(.*?)"$/) do |phone, customer|
  StepsDataCache.cache[phone] = DataOperations::Phone.new(StepsDataCache.cache[customer])
  StepsDataCache.cache[phone].add
	CustomerOperations.add_phone(StepsDataCache.cache[phone])
end

Then(/^I add an email address "(.*?)" for customer "(.*?)"$/) do |email, customer|
  StepsDataCache.cache[email] = DataOperations::Email.new(StepsDataCache.cache[customer])
  StepsDataCache.cache[email].add
	CustomerOperations.add_email(StepsDataCache.cache[email])
end

Then(/^I add a note "(.*?)" for customer "(.*?)"$/) do |note, customer|
  StepsDataCache.cache[note] = DataOperations::Note.new(StepsDataCache.cache[customer])
  CustomerOperations.add_note(StepsDataCache.cache[note]) if StepsDataCache.cache[note].new
end


Then(/^I check all phone numbers "(.*?)", email addresses "(.*?)", and notes "(.*?)" for customer "(.*?)"$/) do |phone, email, note, customer|
  StepsDataCache.cache[phone] = DataOperations::Phone.new(StepsDataCache.cache[customer])
  StepsDataCache.cache[email] = DataOperations::Email.new(StepsDataCache.cache[customer])
  StepsDataCache.cache[note] = DataOperations::Note.new(StepsDataCache.cache[customer])
  CustomerOperations.check_phone_email_note(StepsDataCache.cache[phone], StepsDataCache.cache[email],StepsDataCache.cache[note])
end