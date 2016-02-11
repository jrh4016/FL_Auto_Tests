module Android
	module EquipmentScreen
		def self.OK
			{id:'dialog_switch_yes', timeout:10}
		end
		
		def self.back
			{id:'header_button_back',  timeout:10}
		end
		
		def self.new_equipment
			{id:'header_standard_button_right',  timeout:10}
		end	
		
		def self.save_equipment
			{id:'header_standard_button_right',  timeout:10}
		end	
		
		def self.equipment_name
			{id:'edtext_equipment_name', index:0,  timeout:10}
		end	
		
		def self.serial_number
			{id:'edtext_serial_number', index:0,  timeout:10}
		end	
		
		def self.model_number
			{id:'edtext_model_number', index:0,  timeout:10}
		end	
		
		def self.custom_code
			{id:'edtext_custom_code', index:0,  timeout:10}
		end			
		
		def self.choose_manufacturer
			{id:'btn_add_manufacturer', index:0,  timeout:10}
		end		
		
		def self.select_manufacturer(man)
			{text:"#{man}", index:0, timeout:10}
		end
		
		def self.filter
			{id:'edtext_filter', index:0,  timeout:10}
		end				
			
		def self.choose_location
			{id:'btn_add_location',  timeout:10}
		end		
		
		def self.select_location
			{id:'row_location_list_item_textview_address_line_1', index:0,  timeout:10}
		end		
		
		def self.select(sel)
			{text:"#{sel}", index:0, timeout:10}
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
			
		def self.save_date
			{id:'dialog_date_picker_button_save', timeout:10}
		end
		
		def self.installed_date
			{id:'btn_set_installation_date', index:0,  timeout:10}
		end			
								
		def self.part_warranty_date
			{id:'btn_set_warranty_date', index:0,  timeout:10}
		end			
		
		def self.labor_warranty_date
			{id:'btn_set_labor_warranty', index:0,  timeout:10}
		end				
		
		def self.warranty_holder
			{id:'edtext_warranty_contract_holder', index:0,  timeout:10}
		end			
		
		def self.warranty_number
			{id:'edtext_warranty_contract_number', index:0,  timeout:10}
		end	
		
		def self.next_service_date
			{id:'btn_next_service_call_date', index:0,  timeout:10}
    end

    def self.plus_button
      {id:'new_service_record', timeout:10}
    end

    def self.condition_description
      {id:'text', timeout:10}
    end

    def self.condition_spinner
      {id:'spinner', timeout:10}
    end

    def self.save
      {id:'button_positive', timeout:10}
    end

		def self.open_equipment(equipment)
			{text:"#{equipment.name}", timeout:10}
		end
		
		def self.check(check)
			{text:"#{check}", timeout:10}
    end

    def self.check_date(check)
      {text:"#{check.strftime($CHECK_DATE_FORMAT)}", index:0, timeout:10}
    end
	end
end



####################################################################################################################
#													                            IOS															                             #
####################################################################################################################

module IOS
	module EquipmentScreen
		def self.OK
			'OK'
		end

    def self.submit
      {type:'button', marked:'Submit',  timeout:10}
    end

		def self.done
			{type:'button', marked:'Done',  timeout:10}
    end

    def self.save
      {type:'button', marked:'Save',  timeout:10}
    end
		
		def self.edit
			{type:'button', marked:'Edit',  timeout:10}
		end
		
		def self.add_equipment
			{marked:'Add Equipment',  timeout:10}
		end		
		
		def self.choose_location
			{marked:'n/a', index:0,  timeout:10}
		end		
		
		def self.select(customer)
			{text:"#{customer}", index:0, timeout:10}
		end
		
		def self.choose_manufacturer
			{marked:'n/a', index:0,  timeout:10}
		end
		
		def self.equipment_name
			{marked:'n/a', index:0,  timeout:10}
		end		
	
		def self.serial_number
			{marked:'n/a', index:0,  timeout:10}
		end		
		
		def self.model_number
			{marked:'n/a', index:0,  timeout:10}
		end			
		
		def self.filter
			{marked:'n/a', index:0,  timeout:10}
		end			
		
		def self.custom_code
			{marked:'n/a', index:0,  timeout:10}
		end			
		
		def self.installed_date
			{marked:'n/a', index:0,  timeout:10}
		end			
								
		def self.part_warranty_date
			{marked:'n/a', index:0,  timeout:10}
		end			

		def self.warranty_holder
			{marked:'n/a', index:0,  timeout:10}
		end			
		
		def self.warranty_number
			{marked:'n/a', index:0,  timeout:10}
		end	
		
		def self.next_service_date
			{marked:'n/a', index:0,  timeout:10}
		end			

		def self.labor_warranty_date
			{marked:'n/a', index:0,  timeout:10}
    end

    def self.plus_button
      {type:'button', marked:'plus button',  timeout:10}
    end

    def self.condition_description
      {type:'textView', index:0,  timeout:10}
    end
		
		def self.open_equipment(equipment)
			{marked:"#{equipment.name}", index:0, timeout:10}
    end
		
		def self.back
			{type:'view', marked:'Back', index:0,  timeout:10}
		end
		
		def self.check(check)
			{text:"#{check}", index:0, timeout:10}
    end

    def self.check_date(check)
      {text:"#{check.strftime($CHECK_DATE_FORMAT)}", index:0, timeout:10}
    end
	end	
end