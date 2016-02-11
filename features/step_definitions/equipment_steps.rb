


Then(/^I add new equipment "(.*?)" for customer "(.*?)"$/) do |equipment, customer|
  StepsDataCache.cache['equipments'] = Array.new
  found_line_array = MiscOperations.get_found_lines('Equipment',StepsDataCache.cache[customer].company_name)
  found_line_array.each_index{ |i| StepsDataCache.cache['equipments'].push(DataOperations::Equipment.new(StepsDataCache.cache[customer], 'load', found_line_array[i])) }
  StepsDataCache.cache['equipments'].push(DataOperations::Equipment.new(StepsDataCache.cache[customer], 'add', found_line_array))
  StepsDataCache.cache[equipment] = StepsDataCache.cache['equipments'][-1]
  EquipmentOperations.add(StepsDataCache.cache[equipment])
end

Then(/^I check equipment "(.*?)"$/) do |equipment|
  raise("NO EQUIPMENT #{equipment} EXISTS") if StepsDataCache.cache[equipment].nil?
  EquipmentOperations.check(StepsDataCache.cache[equipment])
end

Then(/^I check the newest equipment for customer "(.*?)"$/) do |customer|
  if StepsDataCache.cache['equipments'].nil?
    StepsDataCache.cache['equipments'] = Array.new
    found_line_array = MiscOperations.get_found_lines('Equipment',StepsDataCache.cache[customer].company_name)
    found_line_array.each_index{ |i| StepsDataCache.cache['equipments'].push(DataOperations::Equipment.new(StepsDataCache.cache[customer], 'load', found_line_array[i])) }
  end
  EquipmentOperations.check(StepsDataCache.cache['equipments'][-1])
end

Then(/^I check all equipment for customer "(.*?)"$/) do |customer|
  if StepsDataCache.cache['equipments'].nil?
    StepsDataCache.cache['equipments'] = Array.new
    found_line_array = MiscOperations.get_found_lines('Equipment',StepsDataCache.cache[customer].company_name)
    found_line_array.each_index{ |i| StepsDataCache.cache['equipments'].push(DataOperations::Equipment.new(StepsDataCache.cache[customer], 'load', found_line_array[i])) }
  end
  StepsDataCache.cache['equipments'].each_index{ |i| EquipmentOperations.check(StepsDataCache.cache['equipments'][i]) }
end