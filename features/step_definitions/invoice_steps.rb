

Then(/^I create invoice "(.*?)" for appointment "(.*?)"$/) do |invoice,appointment|
	StepsDataCache.cache[invoice] = DataOperations::Invoice.new(StepsDataCache.cache[appointment])
	InvoiceOperations.create_invoice(StepsDataCache.cache[invoice])
end

Then(/^I check that invoice "(.*?)" updated after applying service plan "(.*?)" to appointment "(.*?)"$/) do |invoice, service, appointment|
  if StepsDataCache.cache[service].nil?
    StepsDataCache.cache['service agreements'] = Array.new
    found_line_array = MiscOperations.get_found_lines('Service Agreement',StepsDataCache.cache[appointment].company_name)
    found_line_array.each_index{ |i| StepsDataCache.cache['service agreements'].push(DataOperations::ServiceAgreement.new(StepsDataCache.cache[appointment], 'load', found_line_array[i])) }
    StepsDataCache.cache[service] = StepsDataCache.cache['service agreements'][-1]
  end
  if StepsDataCache.cache[invoice].nil?
    StepsDataCache.cache[invoice] = DataOperations::Invoice.new(StepsDataCache.cache[appointment])
    StepsDataCache.cache[invoice].load_from_file
  end
  InvoiceOperations.update_invoice(StepsDataCache.cache[invoice], StepsDataCache.cache[service]) unless StepsDataCache.cache[service].nil? || StepsDataCache.cache[invoice].nil?
end

Then(/^I complete invoice "(.*?)" for appointment "(.*?)" for customer "(.*?)"$/) do |invoice, appointment, customer|
  if StepsDataCache.cache[customer].nil?
    StepsDataCache.cache[customer] = DataOperations::Customer.new
    StepsDataCache.cache[customer].load_from_file
  end
  if StepsDataCache.cache[appointment].nil?
    StepsDataCache.cache['appointments'] = Array.new
    found_line_array = MiscOperations.get_found_lines('Appointment',StepsDataCache.cache[customer].company_name)
    found_line_array.each_index{ |i| StepsDataCache.cache['appointments'].push(DataOperations::Appointment.new(StepsDataCache.cache[customer], 'load', nil, found_line_array[i])) }
    StepsDataCache.cache[appointment] = StepsDataCache.cache['appointments'][-1]
  end
  if StepsDataCache.cache[invoice].nil?
    StepsDataCache.cache[invoice] = DataOperations::Invoice.new(StepsDataCache.cache[customer])
    StepsDataCache.cache[invoice].load_from_file
  end
	InvoiceOperations.complete_invoice(StepsDataCache.cache[invoice], StepsDataCache.cache[appointment], StepsDataCache.cache[customer])
end

Then(/^I open invoice "(.*?)" for customer "(.*?)" from the list$/) do |invoice, customer|
  if StepsDataCache.cache[customer].nil?
    StepsDataCache.cache[customer] = DataOperations::Customer.new
    StepsDataCache.cache[customer].load_from_file
  end
  if StepsDataCache.cache[invoice].nil?
    StepsDataCache.cache[invoice] = DataOperations::Invoice.new(StepsDataCache.cache[customer])
    StepsDataCache.cache[invoice].load_from_file
  end
  wait_for_elements_exist(['tableView index:0'], :timeout => 20) if ENV['MUT'] == 'IOS'
  wait_for_elements_exist(["* id:'fragment_invoice_list_container'"], :timeout => 20) if ENV['MUT'] == 'AND'
  if StepsDataCache.cache[invoice].nil?
    puts "NO INVOICE FOR CUSTOMER #{StepsDataCache.cache[invoice].company_name}"
  else
    NavigationOperations.open_invoice(StepsDataCache.cache[invoice].invoice_number)
  end
end

Then(/^I check invoice "(.*?)"$/) do |invoice|
  unless StepsDataCache.cache[invoice].nil?
    sleep 3
    element_exists("* text:'#{StepsDataCache.cache[invoice].billing_location}'")? MiscOperations.invoiceMathCheck(StepsDataCache.cache[invoice]) : raise("BILLING ADDRESS FOR INVOICE #{StepsDataCache.cache[invoice].invoice_number} NOT FOUND")
  end
end