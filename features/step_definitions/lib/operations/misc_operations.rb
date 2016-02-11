require_relative '../../../support/cal_utils/operations'


module MiscOperations
  class << self
    include Calabash::CalabashUtils::Operations

    ################################################################
    #                    CHECK INVOICE NUMBERS                     #
    ################################################################
    def invoiceMathCheck(invoice)
      discount = ((invoice.discount_amount.to_i * 0.01) * invoice.subtotal).round(2)
      it = 0
      vt = 0
      kdr = 0
      c3p0 = 0
      invoice.item_total.each_index { |inc|
        it += ((invoice.item_total[inc] - (invoice.item_total[inc] / invoice.subtotal) * discount) * 0.05).round(2) if invoice.item_vat1[inc] == 5
        vt += ((invoice.item_total[inc] - (invoice.item_total[inc] / invoice.subtotal) * discount) * 0.055).round(2) if invoice.item_vat2[inc] == 5.5
        kdr += ((invoice.item_total[inc] - (invoice.item_total[inc] / invoice.subtotal) * discount) * 0.07).round(2) if invoice.item_vat1[inc] == 7
        c3p0 += ((invoice.item_total[inc] - (invoice.item_total[inc] / invoice.subtotal) * discount) * 0.06).round(2) if invoice.item_vat2[inc] == 6
      }
      vat1 = (it + kdr).round(2)
      vat2 = (vt + c3p0).round(2)

      if Faker::Config.locale == 'en'
        taxable = 0
        invoice.item_total.each_index { |inc| taxable += invoice.item_total[inc] unless invoice.item_name[inc] == 'Labor' }
        #puts("Taxable is: #{dollar(taxable)}")
        tax = ((taxable - (taxable / invoice.subtotal) * discount) * 0.1).round(2)
        invoice.total = (invoice.subtotal + tax - discount).round(2)
        invoice.amount_due = invoice.total unless invoice.paid_line != 'NOT PAID'
      elsif Faker::Config.locale == 'en-ca'
        tax_total = (it + vt + kdr + c3p0).round(2)
        invoice.total = (invoice.subtotal + tax_total - discount).round(2)
        invoice.amount_due = invoice.total unless invoice.paid_line != 'NOT PAID'
      end

      # PRINTING
      #####################################
      puts('EXPECTING:')
      invoice.item_name.each_index{ |inc| puts("Line #{inc+1}: #{invoice.item_quantity[inc]} - #{invoice.item_name[inc]} - #{invoice.item_vat1[inc]} - #{invoice.item_vat2[inc]} - #{dollar(invoice.item_price[inc])} - #{dollar(invoice.item_total[inc])}")}
      puts("Sub Total: #{dollar( invoice.subtotal)}")
      if Faker::Config.locale == 'en'
        puts("Tax: #{dollar(tax)}")
      elsif Faker::Config.locale == 'en-ca'
        puts("IT: #{dollar(it)}")
        puts("VT: #{dollar(vt)}")
        puts("KDR: #{dollar(kdr)}")
        puts("C3P0: #{dollar(c3p0)}")
        puts("VAT1: #{dollar(vat1)}")
        puts("VAT2: #{dollar(vat2)}")
      end
      puts("Discount: #{dollar(discount)}")
      puts("Total: #{dollar(invoice.total)}")
      puts("Amount Due: #{dollar(invoice.amount_due)}")
      puts("Amount Paid: #{dollar(invoice.amount_paid)}")
      puts("Paid Line: #{invoice.paid_line}")

      # SCROLLING
      #####################################
      uia_scroll_to :view, marked:'Invoice No.' if ENV['MUT'] == 'IOS'
      performAction('scroll_up') if ENV['MUT'] == 'AND'
      uia_scroll_to :view, marked:'Net Total:' if ENV['MUT'] == 'IOS'

      #               LINE ITEM CHECKS
      ################################################################
      invoice.item_name.each_index{ |inc|
        line_quantity = get_elem_attr(InvoiceScreen.line_item_quantity(inc), :text)[0].to_f
        line_name = get_elem_attr(InvoiceScreen.line_item_details(inc), :text)[0].to_s
        if invoice.item_vat1[inc].nil? && Faker::Config.locale == 'en-ca'
          line_vat1 = get_elem_attr(InvoiceScreen.line_item_vat1(inc), :text)[0]
          line_vat2 = get_elem_attr(InvoiceScreen.line_item_vat2(inc), :text)[0]
        elsif Faker::Config.locale == 'en-ca'
          line_vat1 = get_elem_attr(InvoiceScreen.line_item_vat1(inc), :text)[0].split(' ')[-1][0..-2].to_f
          line_vat2 = get_elem_attr(InvoiceScreen.line_item_vat2(inc), :text)[0].split(' ')[-1][0..-2].to_f
        end
        line_price = get_elem_attr(InvoiceScreen.line_item_price(inc), :text)[0][1..-1].gsub(',', '').to_f
        line_total = get_elem_attr(InvoiceScreen.line_item_total(inc), :text)[0][1..-1].gsub(',', '').to_f

        raise("LINE ##{inc+1}s QUANTITY IS WRONG. DISPLAY: #{line_quantity} - EXPECTED: #{invoice.item_quantity[inc]}") unless invoice.item_quantity[inc] == line_quantity
        raise("LINE ##{inc+1}s NAME IS WRONG. DISPLAY: #{line_name} - EXPECTED: #{invoice.item_name[inc]}") unless invoice.item_name[inc] == line_name
        if Faker::Config.locale == 'en-ca'
          raise("LINE ##{inc+1}s VAT1 IS WRONG. DISPLAY: #{line_vat1} - EXPECTED: #{invoice.item_vat1[inc]}") unless invoice.item_vat1[inc] == line_vat1 || (line_vat1 == ' - ' && invoice.item_vat1[inc].nil?)
          raise("LINE ##{inc+1}s VAT2 IS WRONG. DISPLAY: #{line_vat2} - EXPECTED: #{invoice.item_vat2[inc]}") unless invoice.item_vat2[inc] == line_vat2 || (line_vat2 == ' - ' && invoice.item_vat2[inc].nil?)
        end
        raise("LINE ##{inc+1}s PRICE IS WRONG. DISPLAY: #{dollar(line_price)} - EXPECTED: #{dollar(invoice.item_price[inc])}") unless dollar(invoice.item_price[inc]) == dollar(line_price)
        raise("LINE ##{inc+1}s TOTAL IS WRONG. DISPLAY: #{dollar(line_total)} - EXPECTED: #{dollar(invoice.item_total[inc])}") unless dollar(invoice.item_total[inc]) == dollar(line_total)
      }

      # SCROLLING
      #####################################
      uia_scroll_to :view, marked:'already paid textview' if ENV['MUT'] == 'IOS'
      performAction('scroll_down') if ENV['MUT'] == 'AND'


      #               OTHER CHECKS
      ################################################################
      page_subtotal = get_elem_attr(InvoiceScreen.subtotal, :text)[0][1..-1].gsub(',', '').to_f
      page_discount = get_elem_attr(InvoiceScreen.discount, :text)[0][1..-1].gsub(',', '').to_f
      page_total = get_elem_attr(InvoiceScreen.total, :text)[0][1..-1].gsub(',', '').to_f
      page_amount_due = get_elem_attr(InvoiceScreen.amount_due, :text)[0][1..-1].gsub(',', '').gsub('-', '').to_f
      page_already_paid_text = get_elem_attr(InvoiceScreen.already_paid_text, :text)[0][0..-2].gsub('-', '')

      raise("SUB TOTAL IS WRONG. DISPLAYS: #{dollar(page_subtotal)} - EXPECTED: #{dollar(invoice.subtotal)}") unless dollar(page_subtotal) == dollar(invoice.subtotal)
      raise("DISCOUNT IS WRONG. DISPLAYS: #{dollar(page_discount)} - EXPECTED: #{dollar(discount)}") unless dollar(page_discount) == dollar(discount)
      if Faker::Config.locale == 'en'
        page_tax = get_elem_attr(InvoiceScreen.tax, :text)[0][1..-1].to_f
        raise("TAX IS WRONG. DISPLAYS: #{dollar(page_tax)} - EXPECTED: #{dollar(tax)}") unless dollar(tax) == dollar(page_tax)
      elsif Faker::Config.locale == 'en-ca' and ENV['MUT'] == 'IOS'
        raise("IT TOTAL NOT FOUND: #{dollar(it)}") unless element_exists("* text:'#{dollar(it)}'")
        raise("VT TOTAL NOT FOUND: #{dollar(vt)}") unless element_exists("* text:'#{dollar(vt)}'")
        raise("KDR TOTAL NOT FOUND: #{dollar(kdr)}") unless element_exists("* text:'#{dollar(kdr)}'")
        raise("C3P0 TOTAL NOT FOUND: #{dollar(c3p0)}") unless element_exists("* text:'#{dollar(c3p0)}'")
      elsif Faker::Config.locale == 'en-ca' and ENV['MUT'] == 'AND'
        raise("VAT1 TOTAL NOT FOUND: #{dollar(vat1)}") unless element_exists("* text:'#{dollar(vat1)}'")
        raise("VAT2 TOTAL NOT FOUND: #{dollar(vat2)}") unless element_exists("* text:'#{dollar(vat2)}'")
      end
      raise("TOTAL IS WRONG: PAGE DISPLAYS #{dollar(page_total)} - EXPECTED #{dollar(invoice.total)}") unless dollar(page_total) == dollar(invoice.total)
      raise("AMOUNT DUE IS WRONG: PAGE DISPLAYS #{dollar(page_amount_due)} - SHOULD BE #{dollar(invoice.amount_due)}") unless dollar(page_amount_due) == dollar(invoice.amount_due)
      raise("PAID LINE DISPLAYS: #{page_already_paid_text} \nSHOULD BE: #{invoice.paid_line}") if page_already_paid_text.gsub(' ', '').gsub(',', '') != invoice.paid_line.gsub(' ', '').gsub(',', '') && invoice.paid_line != 'NOT PAID'
    end

    ################################################################
    #                       UPDATE INVOICE                         #
    ################################################################
    def invoiceServiceUpdate(invoice,service)
      if Faker::Config.locale == 'en'
        display_price = (get_elem_attr(InvoiceScreen.line_item_price(2), :text)[0][1..-1].to_f).round(2)
        new_price = invoice.item_price[2] * (1 - service.percent_off)
        raise("COUPLINGS PRICE DIDN'T CHANGE FROM #{dollar(invoice.item_price[2])}") if dollar(invoice.item_price[2]) == dollar(display_price)
        raise("COUPLINGS CHANGED INCORRECTLY: #{dollar(new_price)} != #{dollar(display_price)}") if dollar(new_price) != dollar(display_price)
        invoice.item_price[2] = display_price
        invoice.item_total[2] = (invoice.item_quantity[2] * invoice.item_price[2]).round(2)

      elsif Faker::Config.locale == 'en-ca'
        display_price = (get_elem_attr(InvoiceScreen.line_item_price(1), :text)[0][1..-1].to_f).round(2)
        new_price = invoice.item_price[1] * (1 - service.percent_off)
        raise("BODY RETRIEVAL PRICE DIDN'T CHANGE FROM #{dollar(invoice.item_price[1])}") if dollar(invoice.item_price[1]) == dollar(display_price)
        raise("BODY RETRIEVAL CHANGED INCORRECTLY: DISPLAYS: #{dollar(display_price)} \nSHOULD BE: #{dollar(new_price)}") unless dollar(new_price) == dollar(display_price)
        invoice.item_price[1] = display_price
        invoice.item_total[1] = (invoice.item_quantity[1] * invoice.item_price[1]).round(2)
      end

      invoice.subtotal = invoice.item_total.inject{|sum,x| sum + x }
      invoice
    end

    ################################################################
    #                      ADD LABOR/TRAVEL                        #
    ################################################################
    def invoiceAddLaborTravel(invoice)
      if element_exists("* text:'Labor'") && !invoice.item_name.include?('Labor')
        lnum = get_elem_attr(InvoiceScreen.get_labor_line_number, :accessibilityLabel)[0].split('_')[1].to_i if ENV['MUT'] == 'IOS'
        lnum = get_elem_attr(InvoiceScreen.get_labor_line_number, :contentDescription)[0].split('_')[1].to_i if ENV['MUT'] == 'AND'

        #IF BOTH LABOR AND TRAVEL EXIST
        #####################################
        if element_exists("* text:'Travel'") && !invoice.item_name.include?('Travel')
          tnum = get_elem_attr(InvoiceScreen.get_travel_line_number, :accessibilityLabel)[0].split('_')[1].to_i if ENV['MUT'] == 'IOS'
          tnum = get_elem_attr(InvoiceScreen.get_travel_line_number, :contentDescription)[0].split('_')[1].to_i if ENV['MUT'] == 'AND'

          #IF TRAVEL IS LISTED BEFORE LABOR
          #####################################
          if tnum < lnum
            invoice.item_quantity.push(get_elem_attr(InvoiceScreen.line_item_quantity(tnum), :text)[0][1..-1].to_f)
            invoice.item_name.push('Travel')
            invoice.item_vat1.push(nil)
            invoice.item_vat2.push(nil)
            invoice.item_price.push(get_elem_attr(InvoiceScreen.line_item_price(tnum), :text)[0][1..-1].to_f)
            invoice.item_total.push(get_elem_attr(InvoiceScreen.line_item_total(tnum), :text)[0][1..-1].to_f)

            invoice.item_quantity.push(get_elem_attr(InvoiceScreen.line_item_quantity(lnum), :text)[0][1..-1].to_f)
            invoice.item_name.push('Labor')
            invoice.item_vat1.push(nil)
            invoice.item_vat2.push(nil)
            invoice.item_price.push(get_elem_attr(InvoiceScreen.line_item_price(lnum), :text)[0][1..-1].to_f)
            invoice.item_total.push(get_elem_attr(InvoiceScreen.line_item_total(lnum), :text)[0][1..-1].to_f)

          #IF LABOR IS LISTED BEFORE TRAVEL
          #####################################
          else
            invoice.item_quantity.push(get_elem_attr(InvoiceScreen.line_item_quantity(lnum), :text)[0][1..-1].to_f)
            invoice.item_name.push('Labor')
            invoice.item_vat1.push(nil)
            invoice.item_vat2.push(nil)
            invoice.item_price.push(get_elem_attr(InvoiceScreen.line_item_price(lnum), :text)[0][1..-1].to_f)
            invoice.item_total.push(get_elem_attr(InvoiceScreen.line_item_total(lnum), :text)[0][1..-1].to_f)

            invoice.item_quantity.push(get_elem_attr(InvoiceScreen.line_item_quantity(tnum), :text)[0][1..-1].to_f)
            invoice.item_name.push('Travel')
            invoice.item_vat1.push(nil)
            invoice.item_vat2.push(nil)
            invoice.item_price.push(get_elem_attr(InvoiceScreen.line_item_price(tnum), :text)[0][1..-1].to_f)
            invoice.item_total.push(get_elem_attr(InvoiceScreen.line_item_total(tnum), :text)[0][1..-1].to_f)
          end

        #IF ONLY LABOR EXISTS
        #####################################
        else
          invoice.item_quantity.push(get_elem_attr(InvoiceScreen.line_item_quantity(lnum), :text)[0][1..-1].to_f)
          invoice.item_name.push('Labor')
          invoice.item_vat1.push(nil)
          invoice.item_vat2.push(nil)
          invoice.item_price.push(get_elem_attr(InvoiceScreen.line_item_price(lnum), :text)[0][1..-1].to_f)
          invoice.item_total.push(get_elem_attr(InvoiceScreen.line_item_total(lnum), :text)[0][1..-1].to_f)
        end
      invoice.subtotal = invoice.item_total.inject{|sum,x| sum + x }

      #IF NO LABOR LINE IS FOUND
      #####################################
      elsif !element_exists("* text:'Labor'") && !invoice.item_name.include?('Labor')
        puts('----------------------------------------------------')
        puts('             NO LABOR LINE ITEM FOUND               ')
        puts('----------------------------------------------------')
      end
    end

    ################################################################
    #                        SET DISCOUNT                          #
    ################################################################
    def invoiceSetDiscount(invoice)
      if ENV['MUT'] == 'IOS'
        wait_for_none_animating
        uia_scroll_to :view, marked:'Add Discount'
        uia_scroll_to :view, marked:'Set Discount'
        element_exists("* text:'Add Discount'")? touch_elem(InvoiceScreen.add_discount) : touch_elem(InvoiceScreen.set_discount)
        touch_elem(InvoiceScreen.set_percent_discount)
        touch_elem(InvoiceScreen.discount_field)
        clear_text(:textField)
        keyboard_enter_text(invoice.discount_amount.to_s)
        touch_elem(InvoiceScreen.done)
      elsif ENV['MUT'] == 'AND'
        performAction('scroll_down')
        touch_elem(InvoiceScreen.add_discount)
        touch_elem(InvoiceScreen.set_percent_discount)
        set_text_field(InvoiceScreen.discount_field, invoice.discount_amount)
        touch_elem(InvoiceScreen.save_discount)
      end
    end

    ################################################################
    #                         LOAD DATA                            #
    ################################################################
    def get_found_line(type,company_name)
      file = File.open('./features/step_definitions/lib/data/saved_data.txt', 'r')
      num_of_lines = 1
      found = -1
      line = file.gets
      until line == nil
        if line == "--------#{type} Data for #{company_name}--------\n"
          found = num_of_lines
        end
        num_of_lines += 1
        line = file.gets
      end
      file.close
      raise("NO #{type.upcase} DATA FOR #{company_name}") if found == -1
      return found
    end

    def get_found_lines(type,company_name)
      file = File.open('./features/step_definitions/lib/data/saved_data.txt', 'r')
      num_of_lines = 1
      found = Array.new
      line = file.gets
      until line == nil
        if line == "--------#{type} Data for #{company_name}--------\n"
          found.push(num_of_lines)
        end
        num_of_lines += 1
        line = file.gets
      end
      file.close
      found
    end
  end
end
