



module Android
	module LocationScreen
		def self.OK
			{id:'dialog_switch_yes', timeout:10}
		end

		def self.add_location
			{id:'header_standard_button_right', timeout:10}
		end
		
		def self.back
			{id:'btn_back',  timeout:10}
		end
				
		def self.create
			{id:'btn_submit',  timeout:10}
		end
		
		def self.location_name
			{id:'input_location_name', timeout:10}
		end
		
		def self.address_1
			{id:'input_address1', timeout:10}
		end
		
		def self.address_2
			{id:'input_address2', timeout:10}
		end
		
		def self.city
			{id:'input_city', timeout:10}
		end
		
		def self.choose_state
			{id:'spinner_province', timeout:10}
		end
	
		def self.zip
			{id:'input_zipcode', timeout:10}
		end
		
		def self.phone1
			{id:'input_phone1', timeout:10}
		end
		
		def self.choose_phone1_type
			{id:'spinner_phone1_type', timeout:10}
		end
		
		def self.select_phone1_type(type)
			{text:"#{type}", index:0, timeout:10}
		end
		
		def self.phone_1_contact
			{id:'input_phone1_contact', timeout:10}
		end
		
		def self.phone2
			{id:'input_phone2', timeout:10}
		end
		
		def self.choose_phone2_type
			{id:'spinner_phone2_type', timeout:10}
		end
		
		def self.select_phone2_type(type)
			{text:"#{type}", index:0, timeout:10}
		end
		
		def self.phone_2_contact
			{id:'input_phone2_contact', timeout:10}
		end
		
		def self.location_code
			{id:'input_code', timeout:10}
		end
		
		def self.description
			{id:'input_description', timeout:10}
		end
		
		def self.loc_exists(location)
			{text:"#{location.name}:", index:0, timeout:10}
		end
		
		def self.edit
			{id:"edit", index:0, timeout:10}
		end
		
		def self.select(sel)
			{text:"#{sel}", index:0, timeout:10}
		end
		
		def self.check(check)
			{text:"#{check}", index:0, timeout:10}
		end
		
		def self.check_phone(phone)
			{text:"(#{phone[0..2]}) #{phone[3..5]}-#{phone[6..9]}", timeout:10}
		end
	end
end

####################################################################################################################
#													                            IOS															                             #
####################################################################################################################

module IOS
	module LocationScreen
		def self.OK
			'OK'
		end
		
		def self.add_location
			{type:'button', marked:'Add', timeout:10}
		end
		
		def self.location_name
			{type:'textField', marked:'location name', timeout:10}
		end
		
		def self.address_1
			{type:'textField', marked:'address 1', timeout:10}
		end
		
		def self.address_2
			{type:'textField', marked:'address 2', timeout:10}
		end
		
		def self.city
			{type:'textField', marked:'city', timeout:10}
		end
		
		def self.done
			{type:'button', marked:'Done', index:0,  timeout:10}
		end
	
		def self.zip
			{type:'textField', marked:'ZIP', index:0, timeout:10}
		end
		
		def self.phone_1
			{type:'textField', marked:'phone 1', timeout:10}
		end
		
		def self.choose_phone1_type
			{type:'textField', marked:'ZIP', index:0, timeout:10}
		end
		
		def self.select_phone1_type(type)
			{marked:"#{type}", index:0, timeout:10}
		end
		
		def self.phone_1_contact
			{type:'textField', marked:'phone 1 contact name', timeout:10}
		end
		
		def self.phone_2
			{type:'textField', marked:'phone 2', timeout:10}
		end
		
		def self.choose_phone2_type
			{type:'textField', marked:'ZIP', index:0, timeout:10}
		end
		
		def self.select_phone2_type(type)
			{marked:"#{type}", index:0, timeout:10}
		end
		
		def self.phone_2_contact
			{type:'textField', marked:'phone 2 contact name', timeout:10}
		end
		
		def self.location_code
			{type:'textField', marked:'location code', timeout:10}
		end
		
		def self.description
			{type:'textView', marked:'description', timeout:10}
		end
		
		def self.back
			{type:'label', marked:'Back',  timeout:10}
		end
		
		def self.submit
			{type:'button', marked:'Submit',  timeout:10}
		end
		
		def self.loc_exists(location)
			{marked:"#{location.name}", index:0, timeout:10}
		end
		
		def self.check(check)
			{marked:"#{check}", index:0, timeout:10}
    end

    def self.select(sel)
      {text:"#{sel}", index:0, timeout:10}
    end
		
		def self.check_phone(phone)
			{marked:"(#{phone[0..2]}) #{phone[3..5]}-#{phone[6..9]}", timeout:10}
		end
	end	
end