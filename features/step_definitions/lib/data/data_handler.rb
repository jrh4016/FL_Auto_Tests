require 'faker'

module DataOperations
  I18n.enforce_available_locales = true
  ###################################################################################
  #                                 CUSTOMER                                        #
  ###################################################################################
  class Customer
    attr_accessor :company_name, :first_name, :last_name, :address1, :address2, :city, :state, :zip_code, :location
    def initialize
      @company_name=Faker::Company.name
      @first_name=Faker::Name.first_name
      @last_name=Faker::Name.last_name
      @address1=Faker::Address.street_address
      @address2=Faker::Address.secondary_address
      @city=Faker::Address.city
      @state=Faker::Address.state_abbr
      @zip_code=Faker::Address.zip_code
      @location="#{@address1}, #{@address2}, #{@city}, #{@state} #{@zip_code}"
    end
    
    def save_to_file
      f = File.open('./features/step_definitions/lib/data/saved_data.txt', 'a')
      f.puts("--------Customer Data for #{Faker::Config.locale}--------")
      f.puts("Company Name: #{@company_name}")
      f.puts("Name: #{@first_name} - #{@last_name}")
      f.puts("Location: #{@address1} - #{@address2} - #{@city} - #{@state} - #{@zip_code}")
      f.close
    end

    def load_from_file
      found = MiscOperations.get_found_line('Customer', Faker::Config.locale)

      file = File.open('./features/step_definitions/lib/data/saved_data.txt', 'r')
      until found == 0
        file.gets.to_s
        found -= 1
      end

      #Once the indicator line is found, each subsequent line has the data for each subsequent variable in the class
      @company_name = file.gets[0..-2].split(': ')[1]
      name = file.gets[0..-2]
      @first_name = name[/: (.*?) - /m, 1]
      @last_name = name.split(' - ')[1]
      location = file.gets[0..-2]
      @address1 = location[/: (.*?) - /m, 1]
      @address2 = location.split(' - ')[1]
      @city = location.split(' - ')[2]
      @state = location.split(' - ')[3]
      @zip_code= location.split(' - ')[4]
      @location="#{@address1}, #{@address2}, #{@city}, #{@state} #{@zip_code}"
      file.close
    end
  end

  ###################################################################################
  #                                 LOCATION                                        #
  ###################################################################################

  class Location
    attr_accessor :company_name, :name, :address1, :address2, :city, :state, :zip_code, :location, :phone_type1, :phone_number1, :contact1, :phone_type2, :phone_number2, :contact2, :location_code, :description
    def initialize(customer, do_what_next, found_line)
      @company_name = customer.company_name
      add if do_what_next == 'add'
      load_from_file(found_line) if do_what_next == 'load' and !found_line.nil?
    end

    def add
      @name = "New Location ##{SecureRandom.hex[0..5]}"
      @address1 = Faker::Address.street_address
      @address2 = Faker::Address.secondary_address
      @city = Faker::Address.city
      @state = Faker::Address.state_abbr
      @zip_code = Faker::Address.zip_code
      @location = "#{@address1}, #{@address2}, #{@city}, #{@state} #{@zip_code}"
      @phone_type1 = 'Cell'
      @phone_number1 = "817#{rand.to_s[2..8]}"
      @contact1 = Faker::Name.name
      @phone_type2 = 'Work'
      @phone_number2 = "214#{rand.to_s[2..8]}"
      @contact2 = Faker::Name.name
      @location_code = "#{@state}-#{rand.to_s[2..4]}"
      @description = 'This is a test location for hamster nukes'
    end

    def save_to_file
      f = File.open('./features/step_definitions/lib/data/saved_data.txt', 'a')
      f.puts("--------Location Data for #{@company_name}--------")
      f.puts("Location Name: #{@name}")
      f.puts("Location: #{@address1} - #{@address2} - #{@city} - #{@state} - #{@zip_code}")
      f.puts("Contact 1: #{@contact1} - #{@phone_type1} - #{@phone_number1}")
      f.puts("Contact 2: #{@contact2} - #{@phone_type2} - #{@phone_number2}")
      f.puts("Location Code: #{@location_code}")
      f.puts("Description: #{@description}")
      f.close
    end

    def load_from_file(found_line)
      file = File.open('./features/step_definitions/lib/data/saved_data.txt', 'r')
      until found_line == 0
        line = file.gets
        found_line -= 1
      end

      @name = file.gets[0..-2].split(': ')[1]

      location = file.gets[0..-2]
      @address1 = location[/: (.*?) - /m, 1]
      @address2 = location.split(' - ')[1]
      @city = location.split(' - ')[2]
      @state = location.split(' - ')[3]
      @zip_code = location.split(' - ')[4]
      @location = "#{@address1}, #{@address2}, #{@city}, #{@state} #{@zip_code}"

      phone1 = file.gets[0..-2]
      @contact1 = phone1[/: (.*?) - /m, 1]
      @phone_type1 = phone1.split(' - ')[1]
      @phone_number1 = phone1.split(' - ')[2]

      phone2 = file.gets[0..-2]
      @contact2 = phone2[/: (.*?) - /m, 1]
      @phone_type2 = phone2.split(' - ')[1]
      @phone_number2 = phone2.split(' - ')[2]

      @location_code = file.gets[0..-2].split(': ')[1]
      @description = file.gets[0..-2].split(': ')[1]

      file.close
    end

  end

  ###################################################################################
  #                                EQUIPMENT                                        #
  ###################################################################################

  class Equipment
    attr_accessor :company_name, :location, :manufacturer, :name, :serial_num, :model_num, :custom_code, :filter, :installed_date, :part_warranty_date, :warranty_holder, :warranty_num, :next_service_date, :labor_warranty_date, :condition, :description
    def initialize(customer, do_what_next, found_line)
      @company_name = customer.company_name
      add(customer) if do_what_next == 'add'
      load_from_file(found_line) if do_what_next == 'load' and !found_line.nil?
    end

    def add(customer)
      @location = customer.location
      Faker::Config.locale == 'en' ? @manufacturer = 'Argyle Warehouse' : @manufacturer = 'Security Pro USA'
      t = SecureRandom.urlsafe_base64[0..3]
      @name = "Magnus Diamond Blender##{t}"
      @serial_num = "#{SecureRandom.hex[0..2]} - #{rand.to_s[2..6]}"
      @model_num = "(#{t}) #{rand.to_s[2..4]} - #{rand.to_s[2..5]}"
      @custom_code = "MDB-#{t}"
      @filter = 'Blender'
      @installed_date = Date.today.to_datetime
      @part_warranty_date = Date.today.next_year(2).to_datetime
      @warranty_holder = @manufacturer
      @warranty_num = SecureRandom.urlsafe_base64[0..5]
      @next_service_date = Date.today.next_month(3).to_datetime
      @labor_warranty_date = Date.today.next_year.to_datetime
      con = Random.new.rand(1..4)
      case con
        when 1
          @condition = 'Excellent'
          @description = 'Did exactly what it was meant to. No defects'
        when 2
          @condition = 'Good'
          @description = 'Worked OK, however it is pretty loud'
        when 3
          @condition = 'Fair'
          @description = 'Some trouble getting it working straight out of the box'
        when 4
          @condition = 'Poor'
          @description = 'Most likely faulty. Some settings do not work'
      end
    end

    def save_to_file
      f = File.open('./features/step_definitions/lib/data/saved_data.txt', 'a')
      f.puts("--------Equipment Data for #{@company_name}--------")
      f.puts("Name: #{@name}")
      f.puts("Manufacturer: #{@manufacturer}")
      f.puts("Serial Number: #{@serial_num}")
      f.puts("Model Number: #{@model_num}")
      f.puts("Custom Code: #{@custom_code}")
      f.puts("Filter: #{@filter}")
      f.puts("Installation Date: #{@installed_date.strftime($SAVE_DATE_FORMAT)}")
      f.puts("Part Warranty Expiration Date: #{@part_warranty_date.strftime($SAVE_DATE_FORMAT)}")
      f.puts("Warranty: #{@warranty_holder} - #{@warranty_num}")
      f.puts("Labor Warranty Expiration Date: #{@labor_warranty_date.strftime($SAVE_DATE_FORMAT)}")
      f.puts("Next Service Date: #{@next_service_date.strftime($SAVE_DATE_FORMAT)}")
      f.puts("Location: #{@location}")
      f.puts("Condition: #{@condition} - #{@description}")
      f.close
    end

    def load_from_file(found_line)
      file = File.open('./features/step_definitions/lib/data/saved_data.txt', 'r')
      until found_line == 0
        line = file.gets
        found_line -= 1
      end

      @name = file.gets[0..-2].split(': ')[1]
      @manufacturer = file.gets[0..-2].split(': ')[1]
      @serial_num = file.gets[0..-2].split(': ')[1]
      @model_num = file.gets[0..-2].split(': ')[1]
      @custom_code = file.gets[0..-2].split(': ')[1]
      @filter = file.gets[0..-2].split(': ')[1]
      @installed_date = Date.parse file.gets[0..-2].split(': ')[1]
      @part_warranty_date = Date.parse file.gets[0..-2].split(': ')[1]

      warranty = file.gets[0..-2]
      @warranty_holder = warranty[/: (.*?) - /m, 1]
      @warranty_num = warranty.split(' - ')[1]

      @labor_warranty_date = Date.parse file.gets[0..-2].split(': ')[1]
      @next_service_date = Date.parse file.gets[0..-2].split(': ')[1]
      @location = file.gets[0..-2].split(': ')[1]

      con = file.gets[0..-2]
      @condition = con[/: (.*?) - /m, 1]
      @description = con.split(' - ')[1]

      file.close
    end
  end

  ###################################################################################
  #                             SERVICE AGREEMENT                                   #
  ###################################################################################

  class ServiceAgreement
    attr_accessor :company_name, :type, :percent_off, :status, :payment_type, :description, :start_date, :end_date, :agreement_num, :salesperson, :location
    def initialize(customer, do_what_next, found_line)
      @company_name = customer.company_name
      add(customer) if do_what_next == 'add'
      load_from_file(found_line) if do_what_next == 'load' and !found_line.nil?
    end

    def add(customer)
      length = Random.new.rand(1..3)
      file_type = Array.new
      file_percent_off = Array.new
      file_description = Array.new
      file = File.open('./features/step_definitions/lib/data/data.txt', 'r')
      line = file.gets
      until line == nil
        line = line[0..-2]
        if line == "----Service Agreements for #{Faker::Config.locale}----"
          line = file.gets[0..-2]
          until line == 'end'
            file_type.push(line.split(' - ')[0])
            file_percent_off.push(line.split(' - ')[1].to_f)
            file_description.push("##{rand.to_s[2..5]} #{length} Year Agreement #{line.split(' - ')[2]}")
            line = file.gets[0..-2]
          end
          break
        end
        line = file.gets
      end
      file.close
      pick = Random.new.rand(0..file_type.length-1)
      @type = file_type[pick]
      @percent_off = file_percent_off[pick]
      @description = file_description[pick]

      status = Random.new.rand(1..6)
      case status
        when 1
          @status = 'Active'
        when 2
          @status = 'Pending'
        when 3
          @status = 'Cancelled'
        when 4
          @status = 'Expired'
        when 5
          @status = 'Closed'
        when 6
          @status = 'Credit Card Issue'
        else
      end

      pay_type = Random.new.rand(1..6)
      case pay_type
        when 1
          @payment_type = 'Check'
        when 2
          @payment_type = 'Cash'
        when 3
          @payment_type = 'Credit Card'
        when 4
          @payment_type = 'Bill Later'
        when 5
          @payment_type = 'Prepaid'
        when 6
          @payment_type = 'Debit'
        else
      end

      @start_date = Date.today
      @end_date = Date.today.next_year(length)
      @agreement_num = "#{rand.to_s[2..6]}-#{rand.to_s[2..4]}"
      @salesperson = "Service Bot##{rand.to_s[2..4]}"
      @location = customer.location
    end

    def save_to_file
      f = File.open('./features/step_definitions/lib/data/saved_data.txt', 'a')
      f.puts("--------Service Agreement Data for #{@company_name}--------")
      f.puts("Type: #{@type}")
      f.puts("Save: #{(@percent_off*100).round(0)}%")
      f.puts("Status: #{@status}")
      f.puts("Payment Type: #{@payment_type}")
      f.puts("Description: #{@description}")
      f.puts("Effective From: #{@start_date.strftime($SAVE_DATE_FORMAT)} - #{@end_date.strftime($SAVE_DATE_FORMAT)}")
      f.puts("Agreement Number: #{@agreement_num}")
      f.puts("Sales Person: #{@salesperson}")
      f.puts("Location: #{@location}")
      f.close
    end

    def load_from_file(found_line)
      file = File.open('./features/step_definitions/lib/data/saved_data.txt', 'r')
      until found_line == 0
        line = file.gets
        found_line -= 1
      end

      @type = file.gets[0..-2].split(': ')[1]
      @percent_off = file.gets[0..-2].split(': ')[1][0..-1].to_f/100
      @status = file.gets[0..-2].split(': ')[1]
      @payment_type = file.gets[0..-2].split(': ')[1]
      @description = file.gets[0..-2].split(': ')[1]
      dates = file.gets[0..-2]
      @start_date = Date.parse dates[/: (.*?) - /m, 1]
      @end_date = Date.parse dates.split(' - ')[1]
      @agreement_num = file.gets[0..-2].split(': ')[1]
      @salesperson = file.gets[0..-2].split(': ')[1]
      @salesperson = file.gets[0..-2].split(': ')[1]
      file.close
    end
  end

  ###################################################################################
  #                               APPOINTMENT                                       #
  ###################################################################################

  class Appointment
    attr_accessor :company_name, :status, :type, :time, :s_start, :s_end, :a_start, :a_end, :time_address, :location, :billing_location, :full_string, :day, :day_num, :note
    def initialize(customer, do_what_next, location, found_line)
      @company_name = customer.company_name
      add(customer, location, found_line) if do_what_next == 'add'
      load_from_file(found_line) if do_what_next == 'load' && !found_line.nil?
    end

    def add(customer, location, found_line)
      @status = 'Open'
      file = File.open('./features/step_definitions/lib/data/data.txt', 'r')
      line = file.gets
      until line == nil
        line = line[0..-2]
        if line == "----Appointment Type for #{Faker::Config.locale}----"
          @type = file.gets[0..-2]
          break
        end
        line = file.gets
      end
      file.close
      @billing_location = customer.location
      @location = location
      target_day = Time.parse('8:00', (Time.now + 60*60*24))                  #TARGET DAY DEFAULT IS TOMORROW AT 8:00 AM
      @time = Time.parse("#{rand(8..19)}:00", target_day)                     #RANDOM HOUR SET ON TARGET_DAY (TOMORROW)

      hour = Array.new
      file = File.open('./features/step_definitions/lib/data/saved_data.txt', 'r')
      line = file.gets
      until line == nil
        if line[0..23] == '--------Appointment Data'
          (0..4).each { line = file.gets }
          hour.push(Time.parse(file.gets[0..-2].split(': ')[1]))
        end
        line = file.gets
      end unless found_line == nil

      hour = hour.sort
      hour.each_index { |i|
        @time += 3600 if hour[i] == @time                                     #IF THE TIME IS IN USE, INCREMENT AN HOUR
        if @time > Time.parse('19:00', target_day)                            #IF THE TIME IS BEYOND ACCEPTABLE HOURS
          target_day += 60*60*24                                              #INCREMENT TARGET DAY ANOTHER DAY
          @time = target_day                                                  #TIME IS NOW SET TO THE NEXT DAY AT 8:00 AM
        end
      }

      @day = @time.strftime('%a %b')
      @day_num = @time.day.to_s
      @note = "1 hour #{@type} appointment."

      temp_time = Array.new
      temp_time.push(Time.parse("#{@time.hour-2}:00", target_day))
      temp_time.push(Time.parse("#{@time.hour-1}:00", target_day))
      temp_time.push(Time.parse("#{@time.hour}:00", target_day))
      temp_time.push(Time.parse("#{@time.hour+1}:00", target_day))

      ENV['MUT'] == 'IOS'? p = 'p' : p = 'P'                                  #CONVERTS THE LOWERCASE am/pm TO AM/PM FOR IOS
      @a_start = temp_time[0].strftime("%-l:00 %#{p}")
      @a_end = temp_time[1].strftime("%-l:00 %#{p}")
      @s_start = temp_time[2].strftime("%-l:00 %#{p}")
      @s_end = temp_time[3].strftime("%-l:00 %#{p}")
      @full_string = "#{@time.strftime('%A, %B %-d, %Y')} #{@a_start} - #{@a_end}"
      @time_address = "#{@a_start} #{@billing_location}"
    end

    def save_to_file
      f = File.open('./features/step_definitions/lib/data/saved_data.txt', 'a')
      f.puts("--------Appointment Data for #{@company_name}--------")
      f.puts("Status: #{@status}")
      f.puts("Location: #{@location}")
      f.puts("Billing Location: #{@billing_location}")
      f.puts("Appointment Type: #{@type}")
      f.puts("Note: #{@note}")
      f.puts("Time: #{@time}")
      f.puts("Time Set As: #{@s_start} - #{@s_end}")
      f.puts("Time Displayed As: #{@a_start} - #{@a_end}")
      f.puts("Time Address Line: #{@time_address}")
      f.puts("Full String: #{@full_string}")
      f.puts("Day: #{@day} - #{@day_num}")
      f.close
    end

    def load_from_file(found_line)
      target_day = Time.parse('8:00', (Time.now + 60*60*24))                  #TARGET DAY DEFAULT IS TOMORROW AT 8:00 AM

      file = File.open('./features/step_definitions/lib/data/saved_data.txt', 'r')
      until found_line == 0
        line = file.gets
        found_line -=1
      end

      @status = file.gets[0..-2].split(': ')[1]
      @location = file.gets[0..-2].split(': ')[1]
      @billing_location = file.gets[0..-2].split(': ')[1]
      @type = file.gets[0..-2].split(': ')[1]
      @note = file.gets[0..-2].split(': ')[1]
      @time = Time.parse(file.gets[0..-2].split(': ')[1])
      @day = @time.strftime('%a %b')
      @day_num = @time.day.to_s

      temp_time = Array.new
      temp_time.push(Time.parse("#{@time.hour-2}:00", target_day))
      temp_time.push(Time.parse("#{@time.hour-1}:00", target_day))
      temp_time.push(Time.parse("#{@time.hour}:00", target_day))
      temp_time.push(Time.parse("#{@time.hour+1}:00", target_day))

      ENV['MUT'] == 'IOS'? p = 'p' : p = 'P'                                #CONVERTS THE LOWERCASE am/pm TO AM/PM FOR IOS
      @a_start = temp_time[0].strftime("%-l:00 %#{p}")
      @a_end = temp_time[1].strftime("%-l:00 %#{p}")
      @s_start = temp_time[2].strftime("%-l:00 %#{p}")
      @s_end = temp_time[3].strftime("%-l:00 %#{p}")
      @full_string = "#{@time.strftime('%A, %B %-d, %Y')} #{@a_start} - #{@a_end}"
      @time_address = "#{@a_start} #{@billing_location}"
      file.close
    end
  end

  ###################################################################################
  #                                INVOICE                                          #
  ###################################################################################

  class Invoice
    attr_accessor :company_name, :status, :invoice_number, :billing_location, :item_quantity, :item_name, :item_vat1, :item_vat2, :item_price, :item_total, :subtotal, :discount_amount, :total, :amount_due, :amount_paid, :paid_line
    def initialize(appointment)
      @company_name = appointment.company_name unless appointment.nil?
      @status = 'Open'
      @invoice_number = 'NOT SET'
      @billing_location = appointment.location unless appointment.nil?
      @item_quantity = Array.new
      @item_name = Array.new
      @item_vat1 = Array.new
      @item_vat2 = Array.new
      @item_price = Array.new
      @item_total = Array.new

      file = File.open('./features/step_definitions/lib/data/data.txt', 'r')
      line = file.gets
      until line == nil
        line = line[0..-2]
        if line == "----Invoice Items for #{Faker::Config.locale}----"
          line = file.gets[0..-2]
          until line == 'end'
            @item_quantity.push(rand(line.split(' - ')[0].to_i..line.split(' - ')[1].to_i))
            @item_name.push(line.split(' - ')[2])
            line.split(' - ')[3] == '' ? @item_vat1.push(nil) : @item_vat1.push(line.split('-')[3].to_f)
            line.split(' - ')[4] == '' ? @item_vat2.push(nil) : @item_vat2.push(line.split('-')[4].to_f)
            @item_price.push(line.split(' - ')[5].to_f)
            @item_total.push(@item_quantity[-1]*@item_price[-1])
            line = file.gets[0..-2]
          end
          break
        end
        line = file.gets
      end
      file.close

      @subtotal = @item_total.inject{|sum,x| sum + x }
      @discount_amount = (rand(2..5)*5).to_s
      @total = 0
      @amount_due = 0
      @amount_paid = 0
      @paid_line = 'NOT PAID'
    end

    def addItem
      file = File.open('./features/step_definitions/lib/data/data.txt', 'r')
      line = file.gets
      until line == nil
        line = line[0..-2]
        if line == "----Invoice Extra Item for #{Faker::Config.locale}----"
          line = file.gets[0..-2]
          @item_quantity.push(rand(line.split(' - ')[0].to_i..line.split(' - ')[1].to_i))
          @item_name.push(line.split(' - ')[2])
          line.split(' - ')[3] == '' ? @item_vat1.push(nil) : @item_vat1.push(line.split('-')[3].to_f)
          line.split(' - ')[4] == '' ? @item_vat2.push(nil) : @item_vat2.push(line.split('-')[4].to_f)
          @item_price.push(line.split(' - ')[5].to_f)
          @item_total.push(@item_quantity[-1]*@item_price[-1])
          break
        end
        line = file.gets
      end
      file.close
      @subtotal = @item_total.inject{|sum,x| sum + x }
    end

    def save_to_file
      f = File.open('./features/step_definitions/lib/data/saved_data.txt', 'a')
      f.puts("--------Invoice Data for #{@company_name}--------")
      f.puts("Status: #{@status}")
      f.puts("Invoice No: #{@invoice_number}")
      f.puts("Billing Location: #{@billing_location}")
      f.puts("#{@item_quantity.length} items")
      @item_quantity.each_index{|i| f.puts("Line #{i+1}: #{@item_quantity[i]} - #{@item_name[i]} - #{@item_vat1[i]} - #{@item_vat2[i]} - #{@item_price[i]} - #{@item_total[i]}") }
      f.puts("Subtotal: $#{@subtotal}")
      f.puts("Discount: #{@discount_amount}%")
      f.puts("Total: $#{@total}")
      f.puts("Amount Due: $#{@amount_due}")
      f.puts("Already Paid: $#{@amount_paid}")
      f.puts("Payment History: #{@paid_line}")
      f.close
    end

    def load_from_file
      found = MiscOperations.get_found_line('Invoice',@company_name)

      file = File.open('./features/step_definitions/lib/data/saved_data.txt', 'r')
      until found == 0
        file.gets.to_s
        found -= 1
      end

      @status = file.gets[0..-2].split(': ')[1]
      @invoice_number = file.gets[0..-2].split(': ')[1]
      @billing_location = file.gets[0..-2].split(': ')[1]
      how_many_lines = file.gets[0].to_i
      @item_quantity.clear
      @item_name.clear
      @item_vat1.clear
      @item_vat2.clear
      @item_price.clear
      @item_total.clear
      (1..how_many_lines).each{ line = file.gets[0..-2]
        @item_quantity.push(line[/: (.*?) - /m, 1].to_f)
        @item_name.push(line.split(' - ')[1])
        line.split(' - ')[2] == '' ? @item_vat1.push(nil) : @item_vat1.push(line.split('-')[2].to_f)
        line.split(' - ')[3] == '' ? @item_vat2.push(nil) : @item_vat2.push(line.split('-')[3].to_f)
        @item_price.push(line.split(' - ')[4].to_f)
        @item_total.push(line.split(' - ')[5].to_f)
      }
      @subtotal = file.gets[0..-2].split(': $')[1].to_f
      @discount_amount = file.gets.split(': ')[1][0..-1].to_i
      @total = file.gets[0..-2].split(': $')[1].to_f
      @amount_due = file.gets[0..-2].split(': $')[1].to_f
      @amount_paid = file.gets[0..-2].split(': $')[1].to_f
      @paid_line = file.gets[0..-2].split(': ')[1]
      file.close
    end
  end

  ###################################################################################
  #                            PHONE EMAIL NOTE                                     #
  ###################################################################################

  class Phone
    attr_accessor :company_name, :type, :number, :description
    def initialize(customer)
      @company_name = customer.company_name
      @type = Array.new
      @number = Array.new
      @description = Array.new

      file = File.open('./features/step_definitions/lib/data/saved_data.txt', 'r')
      num_of_lines = 1
      found = -1
      line = file.gets
      until line == nil
        line = line[0..-2]
        if line == "----Phone Numbers for #{@company_name}----"
          found = num_of_lines
        end
        num_of_lines += 1
        line = file.gets
      end
      file.close

      if found != -1
        file = File.open('./features/step_definitions/lib/data/saved_data.txt', 'r')
        until found == 0
          file.gets
          found -= 1
        end
        how_many_phone_numbers = file.gets[0..-2].to_i
        until how_many_phone_numbers == 0
          line = file.gets[0..-2]
          @type.push(line.split(' ')[0])
          @number.push(line.split(' ')[1])
          @description.push(line.split(' - ')[1])
          how_many_phone_numbers -= 1
        end
        file.close
      end
    end

    def add
      one = Random.new.rand(1..4)
      case one
        when 1 then @type.push('Work')
        when 2 then @type.push('Home')
        when 3 then @type.push('Cell')
        when 4 then @type.push('Other')
      end
      @number.push("817#{rand.to_s[2..8]}")
      @description.push("#{@company_name} #{@type[-1]} number")
    end

    def save_to_file
      f = File.open('./features/step_definitions/lib/data/saved_data.txt', 'a')
      f.puts("----Phone Numbers for #{@company_name}----")
      f.puts(@number.length)
      @number.each_index{|i| f.puts("#{@type[i]} #{@number[i]} - #{@description[i]}")}
      f.close
    end
  end

  class Email
    attr_accessor :company_name, :address, :description
    def initialize(customer)
      @company_name = customer.company_name
      @address = Array.new
      @description = Array.new

      file = File.open('./features/step_definitions/lib/data/saved_data.txt', 'r')
      num_of_lines = 0
      found = -1
      line = file.gets
      until line == nil
        line = line[0..-2]
        if line == "----Emails for #{@company_name}----"
          found = num_of_lines
        end
        num_of_lines += 1
        line = file.gets
      end
      file.close

      if found != -1
        file = File.open('./features/step_definitions/lib/data/saved_data.txt', 'r')
        until found == -1
          file.gets.to_s
          found -= 1
        end
        how_many_emails = file.gets.to_i
        ix=0
        until ix==how_many_emails
          line = file.gets[0..-2]
          @address.push(line.split(' - ')[0])
          @description.push(line.split(' - ')[1])
          ix+=1
        end
        file.close
      end
    end
    def add
      @address.push(Faker::Internet.email)
      @description.push("Email Address for #{@company_name}")
    end
    def save_to_file
      f = File.open('./features/step_definitions/lib/data/saved_data.txt', 'a')
      f.puts("----Emails for #{@company_name}----")
      f.puts(@address.length)
      @address.each_index{|i| f.puts("#{@address[i]} - #{@description[i]}")}
      f.close
    end
  end

  class Note
    attr_accessor :company_name, :note, :new
    def initialize(customer)
      @company_name = customer.company_name
      @new = true
      file = File.open('./features/step_definitions/lib/data/saved_data.txt', 'r')
      line = file.gets
      until line == nil
        line = line[0..-2]
        if line == "----Note for #{@company_name}----"
          @new = false
          break
        end
        line = file.gets
      end
      file.close

      @note = Faker::Lorem.sentence if @new
    end
    def save_to_file
      f = File.open('./features/step_definitions/lib/data/saved_data.txt', 'a')
      f.puts("----Note for #{@company_name}----")
      f.puts(@note)
      f.close
    end
  end
end