module Android
	module NewAppointmentScreen
		def self.screen(first_name)
			#{type:'textView', text:"#{first_name}", timeout:10}
				{id:'activity_add_appointment_button_select_location', timeout:10}
		end

		
		def self.choose_location
			{id:'activity_add_appointment_button_select_location', timeout:10}
		end
		
		def self.select_location
			{id:'row_location_list_item_textview_address_line_1', index:0, timeout:10}
		end
		
		def self.choose_appointment_type
			{id:'activity_add_appointment_button_select_appointment_type', timeout:10}
		end
		
		def self.select(sel)
		   	{text:"#{sel}", timeout:10}
		end

		def self.save_appointment_type
		   	{text:"Save", timeout:10}
		end
		
		def self.unscheduled_appointment
		   	{text:"Save", timeout:10}
		end
		
		def self.set_start_date
			{id:'activity_add_appointment_button_start_date', timeout:10}
		end
		
		def self.increment_day
			{id:'increment', index:1, timeout:10}
		end
		
		def self.increment_month
			{id:'increment', index:0, timeout:10}
		end
		
		def self.increment_year
			{id:'increment', index:2, timeout:10}
		end
		
		def self.select_day
			{type:'ImageButton', index:2, timeout:10}
		end
		
		def self.select_time(hour)
			{text:"#{hour}", index:0, timeout:10}
		end
		
		def self.save
		   	{text:"Save", timeout:10}
		end
		
		def self.select_start_hour
			{id:'dialog_date_picker_and_selector_spinner', timeout:10}
		end
		
		def self.select_end_hour
			{id:'dialog_appointment_end_time_spinner', timeout:10}
		end
		
		
		def self.set_end_date
			{id: 'activity_add_appointment_button_end_date', timeout:10}
		end
		
		def self.notes
			{id: 'activity_add_appointment_edittext_notes', timeout:10}
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

	end
end



####################################################################################################################
#													                          IOS															                               #
####################################################################################################################


module IOS
	module NewAppointmentScreen
		def self.screen
			{type:'view', marked:'New Appointment Screen', timeout:10}
		end
		
		def self.select(sel)
			{marked:"#{sel}", index:1, timeout:10}
    end

    def self.choose_location
      {type:'buttonLabel', marked:'Location', index:0, timeout:10}
    end
		
		def self.choose_appointment_type
			{marked:'Appointment Type', index:0, timeout:10}
		end

		def self.scheduled
			'Regular'
		end

		def self.start_date
			{type:'label', marked:'Start Date', index:0, timeout:10}
		end
		
		def self.end_date
			{type:'label', marked:'End Date', index:0, timeout:10}
		end

		def self.done
		   	{type:'button', marked:'Done', timeout:10}
		end

		def self.submit
			{text:"Submit", timeout:10}
		end
		
		def self.notes
			{type:'textView', index:0, timeout:10}
		end

	end	
end