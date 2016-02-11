


Then(/^I add a new location "(.*?)" for customer "(.*?)"$/) do |location, customer|
  StepsDataCache.cache['locations'] = Array.new
  found_line_array = MiscOperations.get_found_lines('Location',StepsDataCache.cache[customer].company_name)
  found_line_array.each_index{ |i| StepsDataCache.cache['locations'].push(DataOperations::Location.new(StepsDataCache.cache[customer], 'load', found_line_array[i])) }
  StepsDataCache.cache['locations'].push(DataOperations::Location.new(StepsDataCache.cache[customer], 'add', found_line_array))
  StepsDataCache.cache[location] = StepsDataCache.cache['locations'][-1]
	LocationOperations.add(StepsDataCache.cache[location])
end

Then(/^I check location "(.*?)"$/) do |location|
  raise("NO LOCATION #{location} EXISTS") if StepsDataCache.cache[location].nil?
  LocationOperations.check(StepsDataCache.cache[location])
end

Then(/^I check the newest location for customer "(.*?)"$/) do |customer|
  if StepsDataCache.cache['locations'].nil?
    StepsDataCache.cache['locations'] = Array.new
    found_line_array = MiscOperations.get_found_lines('Location',StepsDataCache.cache[customer].company_name)
    found_line_array.each_index{ |i| StepsDataCache.cache['locations'].push(DataOperations::Location.new(StepsDataCache.cache[customer], 'load', found_line_array[i])) }
  end
  LocationOperations.check(StepsDataCache.cache['locations'][-1])
end

Then(/^I check all locations for customer "(.*?)"$/) do |customer|
  if StepsDataCache.cache['locations'].nil?
    StepsDataCache.cache['locations'] = Array.new
    found_line_array = MiscOperations.get_found_lines('Location',StepsDataCache.cache[customer].company_name)
    found_line_array.each_index{ |i| StepsDataCache.cache['locations'].push(DataOperations::Location.new(StepsDataCache.cache[customer], 'load', found_line_array[i])) }
  end
  StepsDataCache.cache['locations'].each_index{ |i| LocationOperations.check(StepsDataCache.cache['locations'][i]) }
end