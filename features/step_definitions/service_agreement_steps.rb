


Then(/^I add new service agreement "(.*?)" for customer "(.*?)"$/) do |service, customer|
  StepsDataCache.cache['service agreements'] = Array.new
  found_line_array = MiscOperations.get_found_lines('Service Agreement',StepsDataCache.cache[customer].company_name)
  found_line_array.each_index{ |i| StepsDataCache.cache['service agreements'].push(DataOperations::ServiceAgreement.new(StepsDataCache.cache[customer], 'load', found_line_array[i])) }
  StepsDataCache.cache['service agreements'].push(DataOperations::ServiceAgreement.new(StepsDataCache.cache[customer], 'add', found_line_array))
  StepsDataCache.cache[service] = StepsDataCache.cache['service agreements'][-1]
  ServiceAgreementOperations.add(StepsDataCache.cache[service])
end

Then(/^I check service agreement "(.*?)"$/) do |service|
  raise("NO SERVICE AGREEMENT #{service} EXISTS") if StepsDataCache.cache[service].nil?
  ServiceAgreementOperations.check(StepsDataCache.cache[service])
end

Then(/^I check the newest service for customer "(.*?)"$/) do |customer|
  if StepsDataCache.cache['service agreements'].nil?
    StepsDataCache.cache['service agreements'] = Array.new
    found_line_array = MiscOperations.get_found_lines('Service Agreement',StepsDataCache.cache[customer].company_name)
    found_line_array.each_index{ |i| StepsDataCache.cache['service agreements'].push(DataOperations::ServiceAgreement.new(StepsDataCache.cache[customer], 'load', found_line_array[i])) }
  end
  ServiceAgreementOperations.check(StepsDataCache.cache['services agreements'][-1])
end

Then(/^I check all service agreements for customer "(.*?)"$/) do |customer|
  if StepsDataCache.cache['services agreements'].nil?
    StepsDataCache.cache['services agreements'] = Array.new
    found_line_array = MiscOperations.get_found_lines('Service Agreement', StepsDataCache.cache[customer].company_name)
    found_line_array.each_index{ |i| StepsDataCache.cache['services agreements'].push(DataOperations::ServiceAgreement.new(StepsDataCache.cache[customer], 'load', found_line_array[i])) }
  end
  StepsDataCache.cache['services agreements'].each_index{ |i| ServiceAgreementOperations.check(StepsDataCache.cache['services agreements'][i]) }
end