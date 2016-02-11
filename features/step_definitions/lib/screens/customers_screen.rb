module Android
	module CustomersScreen
		def self.screen
			{type:'textView', text:'Customers', timeout:10}
		end

		def self.new_customer
			{id:'header_customer_search_button_add', timeout:10}
		end

		def self.search_text
			{id:'header_customer_search_edittext_search', timeout:10}
		end

		def self.search_button
			{id:'header_customer_search_button_search', timeout:10}
		end

		def self.search_result(company_name)
			{id:'equipmentListItem', text:"#{company_name} ", timeout:10}
		end
		
		def self.back
			{id:'header_button_back', timeout:10}
		end
		
		
		#	DASHBOARD
		def self.top_line(customer)
			{id:'activity_customer_textview_customer_name', text:"#{customer.first_name} #{customer.last_name}, #{customer.company_name}", timeout:10}
		end
		
		def self.bottom_line(customer)
			{text:"#{customer.location}", timeout:10}
		end
		
		def self.locations
			{id:'activity_customer_button_locations', timeout:10}
		end
		
		def self.equipment
			{id:'activity_customer_button_equipment', timeout:10}
		end
		
		def self.new_appointment
			{id:'activity_customer_button_new_appointment', timeout:10}
		end
		
		def self.history
			{id:'activity_customer_button_history', timeout:10}
		end
		
		def self.service_agreement
			{id:'activity_customer_button_service_agreements', timeout:10}
		end
		
		def self.capture_photo
			{id:'activity_customer_button_capture_photo', timeout:10}
		end
		
		def self.photo_gallery
			{id:'activity_customer_button_photo_gallery', timeout:10}
		end
		
		def self.forms
			{id:'customer_button_pdf', timeout:10}
		end
		
		def self.add_phone
			{id:'activity_customer_imageview_new_phone_number', timeout:10}
    end
				
		def self.add_email
			{id:'activity_customer_imageview_new_email_address', timeout:10}
		end	
		
		def self.add_customer_note
			{id:'activity_customer_imageview_add_notes', timeout:10}
		end

		#	EXTRAS
    def self.phone_number
    {id:'dialog_item_and_description_edittext_value', timeout:10}
    end

    def self.phone_description
      {id:'dialog_item_and_description_edittext_description', timeout:10}
    end

    def self.phone_type_spinner
      {id:'dialog_item_and_description_spinner_type', timeout:10}
    end

    def self.save_phone
      {id:'dialog_item_and_description_button_save', timeout:10}
    end
		
		def self.check_phone(phone)
			{text:"(#{phone[0..2]}) #{phone[3..5]}-#{phone[6..9]}", timeout:10}
		end
		
		def self.address_field
			{id:'dialog_item_and_description_edittext_value', timeout:10}
		end
		
		def self.description_field
			{id:'dialog_item_and_description_edittext_description', timeout:10}
		end
		
		def self.save_email
			{id:'dialog_item_and_description_button_save', timeout:10}
    end

    def self.customer_note
      {id:'dialog_add_notes_to_customer_edittext_notes', timeout:10}
    end

    def self.note_box
      {id:'dialog_add_notes_to_customer_edittext_notes', timeout:10}
    end

		def self.save_note
			{id:'dialog_add_notes_to_customer_button_save', timeout:10}
    end

    def self.select(sel)
      {text:"#{sel}", timeout:10}
    end

    def self.check(check)
      {text:"#{check}", timeout:10}
    end
	end
end


####################################################################################################################
#													IOS															   #
####################################################################################################################

module IOS
	module CustomersScreen
		def self.screen
			{type:'view', marked:'Customers', timeout:10}
		end
		
		# 	SEARCH SCREEN
		def self.new_customer
			{type:'button', marked:'Add', timeout:10}
		end
		
		def self.search_text
			{type:'searchBarTextField', timeout:10}
		end

		def self.search_button
			raise "Should call 'keyboard_enter_char('Return')' from operations class instead"
		end

		def self.search_result(company_name)
			{type:'tableViewCell', text:company_name, timeout:10}
		end
		
		
		#	DASHBOARD
		def self.top_line(customer)
			{type:'label', marked:"#{customer.first_name} #{customer.last_name}, #{customer.company_name}", timeout:10}
		end
		
		def self.bottom_line(customer)
			{type:'label', marked:"#{customer.location}", timeout:10}
		end
		
		def self.locations
			{type:'button', marked:'cust location', timeout:10}
		end
		
		def self.equipment
			{type:'button', marked:'cust equipment', timeout:10}
		end
		
		def self.new_appointment
			{type:'button', marked:'New Appointment', timeout:10}
		end
		
		def self.history
			{type:'button', marked:'cust history', timeout:10}
		end
		
		def self.service_agreement
			{type:'button', marked:'cust agreement', timeout:10}
		end
		
		def self.add_phone
			{type:'button', marked:'plus button', index:0, timeout:10}
		end	
				
		def self.add_email
			{type:'button', marked:'plus button', index:1, timeout:10}
		end	
		
		def self.add_customer_note
			{type:'button', marked:'plus button', index:2, timeout:10}
		end
		
		
		
		#	EXTRAS
		def self.phone_number
			{type:"textField", marked:'phone', timeout:10}
		end
		
		def self.phone_description
			{type:"textField index:2", timeout:10}
		end
		
		def self.select_phone_type(type)
			{marked:"#{type}", index:0, timeout:10}
		end
		
		def self.check(check)
			{text:"#{check}", timeout:10}
		end
		
		def self.check_phone(phone)
			{text:"(#{phone[0..2]}) #{phone[3..5]}-#{phone[6..9]}", timeout:10}
		end
		
		def self.address_field
			{type:'textField', index:0, timeout:10}
		end
		
		def self.description_field
			{type:'textField', index:1, timeout:10}
		end
		
		def self.customer_note
			{type:"textField index:0", timeout:10}
		end
		
		def self.done
			{type:'view', marked:"Done", index:0,  timeout:10}
		end
		
		def self.submit
			{type:'button', marked:"Submit", index:0,  timeout:10}
		end
		
	end	
end