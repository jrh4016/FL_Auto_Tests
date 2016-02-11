

Then(/^check that appointment "(.*?)" closed for customer "(.*?)"$/) do |appointment, customer|
  if StepsDataCache.cache[customer].nil?
    StepsDataCache.cache[customer] = DataOperations::Customer.new
    StepsDataCache.cache[customer].load_from_file
  end
  StepsDataCache.cache['appointments'] = Array.new
  found_line_array = MiscOperations.get_found_lines('Appointment',StepsDataCache.cache[customer].company_name)
  found_line_array.each_index{ |i| StepsDataCache.cache['appointments'].push(DataOperations::Appointment.new(StepsDataCache.cache[customer], 'load', nil, found_line_array[i])) }
  StepsDataCache.cache[appointment] = StepsDataCache.cache['appointments'][-1]
  HistoryOperations.check(StepsDataCache.cache[appointment])
end
