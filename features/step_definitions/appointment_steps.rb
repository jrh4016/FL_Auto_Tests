



Then(/^I add a new appointment "(.*?)" for customer "(.*?)" at "(.*?)"$/) do |appointment, customer, location|		            #NEW APPOINTMENT
  StepsDataCache.cache['appointments'] = Array.new
  found_line_array = MiscOperations.get_found_lines('Appointment',StepsDataCache.cache[customer].company_name)
  found_line_array.each_index{ |i| StepsDataCache.cache['appointments'].push(DataOperations::Appointment.new(StepsDataCache.cache[customer], 'load', nil, found_line_array[i])) }
  StepsDataCache.cache['appointments'].push(DataOperations::Appointment.new(StepsDataCache.cache[customer], 'add', StepsDataCache.cache[customer].location, found_line_array)) if location == 'Billing Address'
  StepsDataCache.cache[appointment] = StepsDataCache.cache['appointments'][-1]
  AppointmentOperations.create(StepsDataCache.cache[appointment])
end

Then(/^I open appointment "(.*?)" for customer "(.*?)"$/) do |appointment, customer|														               #OPEN APPOINTMENT
  if StepsDataCache.cache[customer].nil?
    StepsDataCache.cache[customer] = DataOperations::Customer.new
    StepsDataCache.cache[customer].load_from_file
  end
  StepsDataCache.cache['appointments'] = Array.new
  found_line_array = MiscOperations.get_found_lines('Appointment',StepsDataCache.cache[customer].company_name)
  found_line_array.each_index{ |i| StepsDataCache.cache['appointments'].push(DataOperations::Appointment.new(StepsDataCache.cache[customer], 'load', nil, found_line_array[i])) }
  StepsDataCache.cache[appointment] = StepsDataCache.cache['appointments'][-1]
  MyScheduleOperations.open(StepsDataCache.cache[appointment])
end

Then(/^I change the note for appointment "(.*?)"$/) do |appointment|														                            #CHANGE APPOINTMENT NOTE
  AppointmentOperations.change_note(StepsDataCache.cache[appointment])
end

Then(/^I update appointment "(.*?)"$/) do |appointment|                          				                                    #UPDATE APPOINTMENT (FINISH)
  AppointmentOperations.update_status(StepsDataCache.cache[appointment])
end


Then(/^I add equipment "(.*?)" to appointment "(.*?)"$/) do |equipment, appointment|						                                              #ADD EQUIPMENT
  if StepsDataCache.cache[equipment].nil?
    if StepsDataCache.cache['equipments'].nil?
      StepsDataCache.cache['equipments'] = Array.new
      found_line_array = MiscOperations.get_found_lines('Equipment',StepsDataCache.cache[appointment].company_name)
      found_line_array.each_index{ |i| StepsDataCache.cache['equipments'].push(DataOperations::Equipment.new(StepsDataCache.cache[appointment], 'load', found_line_array[i])) }
    end
    StepsDataCache.cache[equipment] = StepsDataCache.cache['equipments'][-1]
  end
  AppointmentOperations.add_equipment(StepsDataCache.cache[equipment]) unless StepsDataCache.cache[equipment].nil?
end

Then(/^I add service agreement "(.*?)" to appointment "(.*?)"$/) do |service, appointment|					                                          #ADD SERVICE AGREEMENT
  if StepsDataCache.cache[service].nil?
    if StepsDataCache.cache['service agreements'].nil?
      StepsDataCache.cache['service agreements'] = Array.new
      found_line_array = MiscOperations.get_found_lines('Service Agreement',StepsDataCache.cache[appointment].company_name)
      found_line_array.each_index{ |i| StepsDataCache.cache['service agreements'].push(DataOperations::ServiceAgreement.new(StepsDataCache.cache[appointment], 'load', found_line_array[i])) }
    end
    StepsDataCache.cache[service] = StepsDataCache.cache['service agreements'][-1]
  end
  AppointmentOperations.add_service_agreement(StepsDataCache.cache[service]) unless StepsDataCache.cache[service].nil?
end