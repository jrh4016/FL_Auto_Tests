module Android
	module NewCustomerScreen
		def self.screen
			{id:'activity_add_customer_edittext_company_name', timeout:10}
		end

		def self.company_name
			{id:'activity_add_customer_edittext_company_name', timeout:10}
		end

		def self.first_name
			{id:'activity_add_customer_edittext_first_name', timeout:10}
		end

		def self.last_name
			{id:'activity_add_customer_edittext_last_name', timeout:10}
		end

		def self.address1
			{id:'activity_add_customer_edittext_address1', timeout:10}
		end
		
		def self.address2
			{id:'activity_add_customer_edittext_address2', timeout:10}
		end

		def self.city
			{id:'activity_add_customer_edittext_address_city', timeout:10}
		end

		def self.state_spinner
			{id:'activity_add_customer_spinner_provinces', timeout:10}
		end
		
		def self.select(sel)
			{text:"#{sel}", timeout:10}
		end

		def self.dropdown_state(state)
			{text:state, timeout:10}
		end

		def self.zip_code
			{id:'activity_add_customer_edittext_address_zip', timeout:10}
		end

		def self.submit
			{id:'header_standard_button_right', timeout:10}
		end

	end
end



####################################################################################################################
#													IOS															   #
####################################################################################################################

module IOS
	module NewCustomerScreen
		def self.screen
			{marked:'company name', timeout:10}
		end
		
		def self.select(sel)
			{text:"#{sel}", index:0, timeout:10}
		end

		def self.company_name
			{marked:'company name', timeout:10}
		end

		def self.first_name
			{marked:'first name', timeout:10}
		end

		def self.last_name
			{marked:'last name', timeout:10}
		end

		def self.address1
			{marked:'address 1', timeout:10}
		end
		
		def self.address2
			{marked:'address 2', timeout:10}
		end

		def self.city
			{marked:'city', timeout:10}
		end

		def self.state
			{marked:'state', timeout:10}
		end

		def self.dropdown_state(state)
			{marked:state, index:0, timeout:10}
		end

		def self.zip_code
			{marked:'ZIP',  timeout:10}
		end

		def self.done
			{type:'button', marked:'Done',  timeout:10}
		end

		def self.submit
			{type:'button', marked:'Submit',  timeout:10}
		end

	end	
end