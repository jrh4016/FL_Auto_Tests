require_relative '../../../support/cal_utils/operations'


module Android
  module InvoiceOperations
    class << self
      include Calabash::CalabashUtils::Operations
	   
      #############################
      #	      CREATE INVOICE	    #
      #############################
      def create_invoice(invoice)
        elem_exists? (InvoiceScreen.address(invoice))
        touch_elem(InvoiceScreen.add_line_item)							                                                      #ADD LINE ITEMS
        touch_elem(InvoiceScreen.standard)
        touch_elem(InvoiceScreen.view_all)
        wait_for_elements_exist(["textView text:'#{invoice.item_name[0]}'"], :timeout => 4)
        invoice.item_name.each_index { |i|
          performAction('scroll_down') unless element_exists("textView text:'#{invoice.item_name[i]}'")
          touch_elem(InvoiceScreen.select(invoice.item_name[i]))
          set_text_field(InvoiceScreen.quantity, invoice.item_quantity[i].to_s)
          touch_elem(InvoiceScreen.add_to_list)
        }
        touch_elem(InvoiceScreen.save_items)
        MiscOperations.invoiceSetDiscount(invoice)
        MiscOperations.invoiceMathCheck(invoice)

        touch_elem(InvoiceScreen.next)										                                                        #SUBMIT
        touch_elem(InvoiceScreen.create_invoice)
        touch_elem(AppointmentScreen.invoice)
        wait_for_elements_exist(["textView text:'Invoice no. '"], :timeout => 10)
        invoice.invoice_number = (query "textView id:'activity_invoice_textview_invoice_number'", :text)[0]
        invoice.save_to_file
      end

      ##########################################################
      #		  		         AND UPDATE  INVOICE	  		 		       #
      ##########################################################

      def update_invoice(invoice, service)
        wait_for_elements_exist(["* id:'activity_invoice_textview_customer_name'"], :timeout => 4)
        elem_exists? (InvoiceScreen.address(invoice))
        MiscOperations.invoiceSetDiscount(invoice)                                                              #SET/UPDATE DISCOUNT TO PERCENT
        MiscOperations.invoiceServiceUpdate(invoice, service)                                                   #UPDATE INVOICE
        MiscOperations.invoiceMathCheck(invoice)                                                                #CHECK
        touch_elem(InvoiceScreen.next)
        touch_elem(InvoiceScreen.save_invoice)
        invoice.save_to_file                                                                                    #SAVE TO FILE
      end

      ##########################################################
      #		  	           AND COMPLETE INVOICE		  	     	     #
      ##########################################################

      def complete_invoice(invoice, appointment,customer)
        elem_exists? (InvoiceScreen.address(invoice))
        MiscOperations.invoiceAddLaborTravel(invoice)

        s = invoice.item_name.length
        invoice.addItem                                                                                           #ADDS NEW LINE ITEMS TO INVOICE DATA HANDLER
        diff = invoice.item_name.length - s
        if diff > 0
          touch_elem(InvoiceScreen.add_line_item)							                                                    #ADD LINE ITEMS
          touch_elem(InvoiceScreen.standard)
          touch_elem(InvoiceScreen.view_all)
          wait_for_elements_exist(["textView text:'#{invoice.item_name[0]}'"], :timeout => 10)
          until s == invoice.item_name.length
            performAction('scroll_down') unless element_exists("textView text:'#{invoice.item_name[s]}'")
            touch_elem(InvoiceScreen.select(invoice.item_name[s]))
            set_text_field(InvoiceScreen.quantity, invoice.item_quantity[s].to_s)
            touch_elem(InvoiceScreen.add_to_list)
            s+=1
          end
          touch_elem(InvoiceScreen.save_items)
        end
        performAction('scroll_down')
        MiscOperations.invoiceSetDiscount(invoice)
        MiscOperations.invoiceMathCheck(invoice)                                                                  #CHECK

        touch_elem(InvoiceScreen.next)
        touch_elem(InvoiceScreen.complete_invoice)
        invoice.save_to_file
        touch_elem(InvoiceScreen.select_credit)
        touch_elem(InvoiceScreen.save_payment)
        touch_elem(InvoiceScreen.skip) unless element_exists('textField index:5')

        wait_for_elements_exist(["* id:'activity_credit_card_payment_edittext_name_on_card'"], :timeout => 10)    #ENTER CC INFORMATION
        sleep 0.5
        performAction('go_back')
        set_text_field(InvoiceScreen.name_on_card, "#{customer.first_name} #{customer.last_name}")
        set_text_field(InvoiceScreen.card_number, '4111111111111111')
        set_text_field(InvoiceScreen.month_expiration, '12')
        set_text_field(InvoiceScreen.year_expiration, '2015')
        set_text_field(InvoiceScreen.cvv, '954')
        touch_elem(InvoiceScreen.submit)							                                                            #COMPLETE INVOICE
        invoice.amount_paid = invoice.amount_due
        invoice.paid_line = "#{Date.today.strftime('%-m/%-d/%Y')}   $#{sprintf '%.2f', invoice.amount_paid}   Credit Card"
        invoice.amount_due = 0
        invoice.save_to_file
        wait_for_elements_exist(["imageView id:'activity_dashboard_button_customers'"], :timeout => 30)
        appointment.status = 'Closed'
        appointment.save_to_file
      end
    end
  end
end




####################################################################################################################
#													                           IOS															                             #
####################################################################################################################

module IOS
  module InvoiceOperations
    class << self
      include Calabash::CalabashUtils::Operations
	   
      #############################
      #	      CREATE INVOICE	    #
      #############################
      def create_invoice(invoice)
        elem_exists? (InvoiceScreen.address(invoice))
        touch_elem(InvoiceScreen.add_line_item)							                                                      #ADD LINE ITEMS
        uia_tap_mark(InvoiceScreen.price_book)
        touch_elem(InvoiceScreen.view_all)

        invoice.item_name.each_index { |i|
          scroll('tableView index:0', :down) unless element_exists("label text:'#{invoice.item_name[i]}'")
          touch_elem(InvoiceScreen.select(invoice.item_name[i]))
          touch_elem(InvoiceScreen.quantity)
          clear_text(:textField)
          keyboard_enter_text(invoice.item_quantity[i].to_s)
          touch_elem(InvoiceScreen.done)
        }
        invoice.item_name.length > 1? touch_elem(InvoiceScreen.add_mult(invoice.item_name.length)) : touch_elem(InvoiceScreen.add_one)

        MiscOperations.invoiceSetDiscount(invoice)

        uia_scroll_to :view, marked:'description'
        clear_text("textView marked:'description'")
        set_text_field(InvoiceScreen.notes, "Custom Invoice ##{SecureRandom.hex[0..4]}")
        touch_elem(InvoiceScreen.done)

        MiscOperations.invoiceMathCheck(invoice)                                                                  #MATH

        touch_elem(InvoiceScreen.next)									                                                          #SUBMIT
        uia_tap_mark('YES')
        uia_tap_mark('OK') if element_exists("* accessibilityLabel:'OK' index:0")

        wait_for_elements_exist(["view marked:'appt invoice'"], :timeout => 10)                                   #REOPEN FOR INVOICE NUMBER
        touch_elem(AppointmentScreen.invoice)
        wait_for_elements_exist(["view marked:'invoice number'"], :timeout => 10)
        invoice.invoice_number = (query "view accessibilityLabel:'invoice number'", :text)[0]
        invoice.save_to_file
      end

      ##########################################################
      #		  		          IOS UPDATE INVOICE	  		 		       #
      ##########################################################

      def update_invoice(invoice, service)
        wait_for_elements_exist(["label marked:'customer'"], :timeout => 10)
        elem_exists? (InvoiceScreen.address(invoice))
        MiscOperations.invoiceSetDiscount(invoice)                                                              #SET/UPDATE DISCOUNT TO PERCENT
        MiscOperations.invoiceServiceUpdate(invoice, service)                                                   #UPDATE INVOICE
        MiscOperations.invoiceMathCheck(invoice)                                                                #CHECK
        touch_elem(InvoiceScreen.next)
        uia_tap_mark('Save Invoice')
        invoice.save_to_file                                                                                    #SAVE TO FILE
      end

      ##########################################################
      #		  	           IOS COMPLETE INVOICE		  	     	     #
      ##########################################################

      def complete_invoice(invoice, appointment, customer)
        elem_exists? (InvoiceScreen.address(invoice))
        MiscOperations.invoiceSetDiscount(invoice)
        MiscOperations.invoiceAddLaborTravel(invoice)

        s = invoice.item_name.length
        invoice.addItem                                                                                          #ADDS NEW LINE ITEMS TO INVOICE DATA HANDLER
        diff = invoice.item_name.length - s
        if diff > 0
          touch_elem(InvoiceScreen.add_line_item)							                                                    #ADD LINE ITEMS
          uia_tap_mark(InvoiceScreen.price_book)
          touch_elem(InvoiceScreen.view_all)
          until s == invoice.item_name.length
            scroll('tableView index:0', :down) unless element_exists("label text:'#{invoice.item_name[s]}'")
            touch_elem(InvoiceScreen.select(invoice.item_name[s]))
            touch_elem(InvoiceScreen.quantity)
            clear_text(:textField)
            keyboard_enter_text(invoice.item_quantity[s].to_s)
            touch_elem(InvoiceScreen.done)
            s+=1
          end
          diff > 1? touch_elem(InvoiceScreen.add_mult(diff)) : touch_elem(InvoiceScreen.add_one)
        end

        MiscOperations.invoiceMathCheck(invoice)                                                                  #CHECK

        touch_elem(InvoiceScreen.next)
        wait_for_elements_exist(["label text:'Complete Invoice'"], :timeout => 10)
        uia_tap_mark('Complete Invoice')
        uia_tap_mark('OK')
        invoice.save_to_file
        wait_for_elements_exist(["label text:'Credit Card'"], :timeout => 10)                                     #SELECT PAY WITH CREDIT CARD
        uia_tap_mark('Credit Card')
        uia_tap_mark('OK')

        wait_for_elements_exist(['textField index:0'], :timeout => 10)                                            #ENTER CC INFORMATION
        set_text_field(InvoiceScreen.name_on_card, "#{customer.first_name} #{customer.last_name}")
        set_text_field(InvoiceScreen.card_number, '4111111111111111')
        set_text_field(InvoiceScreen.month_expiration, '12')
        set_text_field(InvoiceScreen.year_expiration, '2015')
        set_text_field(InvoiceScreen.cvv, '954')

        touch_elem(InvoiceScreen.submit)							                                                            #COMPLETE INVOICE
        invoice.amount_paid = invoice.amount_due
        invoice.paid_line = "#{Date.today.strftime('%-m/%-d/%Y')}   $#{sprintf '%.2f', invoice.amount_paid}   Credit Card "
        invoice.amount_due = 0
        invoice.save_to_file
        wait_for_elements_exist(["view marked:'Dashboard' index:0"], :timeout => 30)
        appointment.status = 'Closed'
        appointment.save_to_file
      end
    end
  end
end