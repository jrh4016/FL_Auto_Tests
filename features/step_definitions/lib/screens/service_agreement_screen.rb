module Android
	module ServiceAgreementScreen
		def self.new
			{id:'header_standard_button_right', timeout:10}
		end		
		
		def self.save_agreement
			{id:'activity_add_service_agreement_button_save', timeout:10}
		end
		
		def self.save
			{id:'dialog_service_agreement_agreement_button_save', timeout:10}
		end
		
		def self.save_date
			{id:'dialog_date_picker_button_save', timeout:10}
		end
		
		def self.select(index)
			{text:"#{index}",  timeout:10}
		end		
		
		def self.choose_service_plan
			{id:'activity_add_service_agreement_linearlayout_service_agreement', timeout:10}
		end	
		
		def self.service_plan_list
			{id:'dialog_service_agreement_agreement_number_of_systems_spinner', timeout:10}
		end
		
		def self.save_service_plan
			{id:'dialog_service_agreement_agreement_button_save', timeout:10}
		end
		
		def self.choose_status
			{id:'activity_add_service_agreement_linearlayout_status', timeout:10}
		end	
		
		def self.choose_payment_type
			{id:'activity_add_service_agreement_linearlayout_payment_type', timeout:10}
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
		
		def self.start_date
			{id:'activity_add_service_agreement_linearlayout_start_date', timeout:10}
		end	
		
		def self.end_date
			{id:'activity_add_service_agreement_linearlayout_end_date', timeout:10}
		end	
		
		def self.description
			{id:'activity_add_service_agreement_edittext_description',  timeout:10}
		end		
		
		def self.salesperson
			{id:'activity_add_service_agreement_edittext_sales_person',  timeout:10}
		end
		
		def self.agreement_number
			{id:'activity_add_service_agreement_edittext_agreement_number',  timeout:10}
		end		
		
		def self.systems_number
			{id:'activity_add_service_agreement_linearlayout_systems_number',  timeout:10}
		end							
		
		def self.select_location(index)
			{index:"#{index}", timeout:10}
		end
		
		def self.back
			{id:'header_button_back', index:0,  timeout:10}
		end
		
		def self.service_exists(service)
			{text:"#{service.description}", index:0, timeout:10}
		end
		
		def self.check(check)
			{text:"#{check}", index:0, timeout:10}
    end

    def self.check_date(check)
      {text:"#{check.strftime($CHECK_DATE_FORMAT)}", index:0, timeout:10}
    end
		
		def self.check_description(check)
			{text:"#{check}", index:0, timeout:10}
		end
	end
end



####################################################################################################################
#													IOS															   #
####################################################################################################################

module IOS
	module ServiceAgreementScreen
		def self.OK
			'OK'
		end
	
		def self.new
			{type:'button', marked:'New', index:0, timeout:10}
		end
	
		def self.choose_status
			{type:'button', index:0, timeout:10}
		end	
		
		def self.select(type)
			{marked:"#{type}", index:0,  timeout:10}
		end
		
		def self.choose_payment_type
			{type:'button', index:1, timeout:10}
		end		
		
		def self.choose_service_plan
			{type:'button', index:2, timeout:10}
		end		
		
		def self.description
			{type:'TextView', index:0,  timeout:10}
		end		
		
		def self.start_date
			{type:'button', index:1, timeout:10}
		end	
		
		def self.end_date
			{type:'button', index:1, timeout:10}
		end	
		
		def self.agreement_number
			{type:'TextField', index:0,  timeout:10}
		end		
		
		def self.salesperson
			{type:'TextField', index:1,  timeout:10}
		end
		
		def self.systems_number
			{type:'TextField', index:2,  timeout:10}
		end							
		
		def self.done
			{type:'button', marked:'Done',  timeout:10}
		end
			
		def self.submit
			{type:'button', marked:'Submit',  timeout:10}
		end
		
		def self.back
			{type:'view', marked:'Back', index:0,  timeout:10}
		end

		def self.save
			'Save'
		end
		
		def self.service_exists(service)
			{marked:"#{service.type} #{service.description}", index:0, timeout:10}
		end
		
		def self.check(check)
			{marked:"#{check}", index:0, timeout:10}
    end

    def self.check_date(check)
      {text:"#{check.strftime($CHECK_DATE_FORMAT)}", index:0, timeout:10}
    end
		
		def self.check_description(check)
			{text:"#{check}", index:0, timeout:10}
		end
	end	
end