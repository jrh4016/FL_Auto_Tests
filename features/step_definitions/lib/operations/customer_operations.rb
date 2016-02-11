require_relative '../../../support/cal_utils/operations'
require_relative '../screens/customers_screen'
require 'calabash-android/operations'
require 'calabash-cucumber/operations'

module Android
  module CustomerOperations 
    class << self
      include Calabash::CalabashUtils::Operations

      ##########################################################
      #		  		          AND CREATE CUSTOMER	  	 			       #
      ##########################################################
      def new_customer(customer)
        touch_elem(CustomersScreen.new_customer)
        elem_exists? NewCustomerScreen.company_name
        set_text_field(NewCustomerScreen.company_name, customer.company_name)
        set_text_field(NewCustomerScreen.first_name, customer.first_name)
        set_text_field(NewCustomerScreen.last_name, customer.last_name)
        set_text_field(NewCustomerScreen.address1, customer.address1)
        set_text_field(NewCustomerScreen.address2, customer.address2)
        set_text_field(NewCustomerScreen.city, customer.city)
        touch_elem(NewCustomerScreen.state_spinner)
        sleep 0.2
        #puts customer.state
        scroll_row_until_elem("* text:'#{customer.state}' index:0", 3, 0)
        touch_elem(NewCustomerScreen.select(customer.state))
        set_text_field(NewCustomerScreen.zip_code, customer.zip_code)
        touch_elem(NewCustomerScreen.submit)
        customer.location = "#{customer.address1}, #{customer.address2}, #{customer.city}, #{customer.state} #{customer.zip_code}"

        customer.save_to_file
      end

      ##########################################################
      #		  		         AND SEARCH AND OPEN 	 			           #
      ##########################################################
      def search(customer)
        set_text_field(CustomersScreen.search_text, customer.company_name)
        touch_elem(CustomersScreen.search_button)
        touch_elem(CustomersScreen.search_result(customer.company_name))
        elem_exists? CustomersScreen.top_line(customer)
        elem_exists? CustomersScreen.bottom_line(customer)
      end

      ##########################################################
      #		  		            AND ADD PHONE			                 #
      ##########################################################
      def add_phone(phone)
        wait_for_elements_exist(["textView id:'activity_customer_textview_customer_name'"], :timeout => 10)
        touch_elem(CustomersScreen.add_phone)
        set_text_field(CustomersScreen.phone_description, phone.description[-1])
        set_text_field(CustomersScreen.phone_number, phone.number[-1])
        touch_elem(CustomersScreen.phone_type_spinner)
        touch_elem(CustomersScreen.select(phone.type[-1]))
        touch_elem(CustomersScreen.save_phone)
        phone.save_to_file
      end

      ##########################################################
      #		  		            AND ADD EMAIL			                 #
      ##########################################################
      def add_email(email)
        wait_for_elements_exist(["textView id:'activity_customer_textview_customer_name'"], :timeout => 10)
        sleep 0.5
        performAction('scroll_down')
        touch_elem(CustomersScreen.add_email)

        set_text_field(CustomersScreen.address_field, email.address[-1])
        set_text_field(CustomersScreen.description_field, email.description[-1])
        touch_elem(CustomersScreen.save_email)
        email.save_to_file
      end

      ##########################################################
      #		  		            AND ADD NOTE		                   #
      ##########################################################
      def add_note(note)
        wait_for_elements_exist(["textView id:'activity_customer_textview_customer_name'"], :timeout => 10)
        sleep 0.5
        performAction('scroll_down')
        touch_elem(CustomersScreen.add_customer_note)

        set_text_field(CustomersScreen.note_box, note.note)
        touch_elem(CustomersScreen.save_note)
        note.save_to_file
      end

      def check_phone_email_note(phone, email, note)
        wait_for_elements_exist(["textView id:'activity_customer_textview_customer_name'"], :timeout => 10)
        phone.type.each_index{ |i|                                                                      #CHECK PHONE NUMBERS
          elem_exists? CustomersScreen.check_phone(phone.number[i])
          elem_exists? CustomersScreen.check(phone.type[i])
          elem_exists? CustomersScreen.check(phone.description[i]) }
        performAction('scroll_down')
        email.address.each_index{ |i|                                                                   #CHECK EMAIL ADDRESSES
          elem_exists? CustomersScreen.check(email.address[i])
          elem_exists? CustomersScreen.check(email.description[i]) }
        elem_exists? CustomersScreen.check(note.note)                                                   #CHECK NOTE
      end
    end
  end
end



####################################################################################################################
#													                          IOS															                               #
####################################################################################################################

module IOS
  module CustomerOperations 
    class << self
      include Calabash::CalabashUtils::Operations

      ##########################################################
      #		  		          IOS CREATE CUSTOMER			             #
      ##########################################################
      def new_customer(customer)
        touch_elem(CustomersScreen.new_customer)
        elem_exists? NewCustomerScreen.company_name
        set_text_field(NewCustomerScreen.company_name, customer.company_name)
        set_text_field(NewCustomerScreen.first_name, customer.first_name)
        set_text_field(NewCustomerScreen.last_name, customer.last_name)
        set_text_field(NewCustomerScreen.address1, customer.address1)
        set_text_field(NewCustomerScreen.address2, customer.address2)
        set_text_field(NewCustomerScreen.city, customer.city)
        scroll_row_until_elem("* text:'#{customer.state}' index:0", 5, 0)
        touch_elem(NewCustomerScreen.select(customer.state))
        touch_elem(NewCustomerScreen.select(customer.state))
        touch_elem(NewCustomerScreen.done)
        touch_elem(NewCustomerScreen.zip_code)
        keyboard_enter_text(customer.zip_code)
        touch_elem(NewCustomerScreen.submit)

        customer.save_to_file
      end

      ##########################################################
      #		  		          IOS SEARCH AND OPEN		               #
      ##########################################################
      def search(customer)
        set_text_field(CustomersScreen.search_text, customer.company_name)
        touch_elem(CustomersScreen.search_result(customer.company_name))
        elem_exists? CustomersScreen.top_line(customer)
        elem_exists? CustomersScreen.bottom_line(customer)
      end

      ##########################################################
      #		  		            IOS ADD PHONE			                 #
      ##########################################################
      def add_phone(phone)
        uia_scroll_to :view, marked:'Phone Numbers'
        touch_elem(CustomersScreen.add_phone)

        touch_elem(CustomersScreen.select_phone_type(phone.type[-1].upcase))
        touch_elem(CustomersScreen.select_phone_type(phone.type[-1].upcase))
        touch_elem(CustomersScreen.done)
        keyboard_enter_text(phone.number[-1])
        set_text_field(CustomersScreen.phone_description, phone.description[-1])
        touch_elem(CustomersScreen.submit)
        phone.save_to_file
      end

      ##########################################################
      #		  		            IOS ADD EMAIL			                 #
      ##########################################################
      def add_email(email)
        uia_scroll_to :view, marked:'Email Addresses'
        touch_elem(CustomersScreen.add_email)

        set_text_field(CustomersScreen.address_field, email.address[-1])
        set_text_field(CustomersScreen.description_field, email.description[-1])
        touch_elem(CustomersScreen.submit)
        email.save_to_file
      end

      ##########################################################
      #		  		            IOS ADD NOTE		                   #
      ##########################################################
      def add_note(note)
        uia_scroll_to :view, marked:'Customer Notes'
        touch_elem(CustomersScreen.add_customer_note)

        keyboard_enter_text(note.note)
        touch_elem(CustomersScreen.submit)
        note.save_to_file
      end

      def check_phone_email_note(phone, email, note)
        uia_scroll_to :view, marked:'Phone Numbers'                                                             #CHECK PHONE NUMBERS
        phone.type.each_index{ |i|
          elem_exists? CustomersScreen.check(phone.type[i])
          elem_exists? CustomersScreen.check_phone(phone.number[i])
          elem_exists? CustomersScreen.check(phone.description[i]) }
        uia_scroll_to :view, marked:'Email Addresses'                                                           #CHECK EMAIL ADDRESSES
        email.address.each_index{ |i|
          elem_exists? CustomersScreen.check(email.address[i])
          elem_exists? CustomersScreen.check(email.description[i]) }
        uia_scroll_to :view, marked:'Edit Customer'                                                             #CHECK NOTE
        elem_exists? CustomersScreen.check(note.note)
      end
    end
  end
end
