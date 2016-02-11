module Android
	module EstimateScreen

		def self.edit_location
			{id:'invoice_location_button_edit', timeout:10}
		end

		def self.location(customer)
			{id:'row_location_list_item_textview_address_line_1', text:"#{customer.address1} #{customer.address2}", timeout:10}
		end
		
		def self.add_line_item
			{id:'activity_estimate_button_add_line_item', timeout:10}
		end

		def self.standard
			{id:'dialog_yes_no_response_button_yes', timeout:10}
		end

		def self.view_all
			{id:'invoiceListItemName', text:'<View All>', timeout:10}
		end
		
		def self.air_vent
			{id:'layout_row_product_name_price_description_text_name', text:'Air Vent', timeout:10}
		end		
		
		def self.add_to_list
			{id:'dialog_layout_add_line_item_button_add', timeout:10}
		end	
			
		def self.save
			{id:'header_standard_button_right', timeout:10}
		end			
		
		def self.custom
			{id:'dialog_yes_no_response_button_no', timeout:10}
		end

		def self.item_name
			{id:'dialog_add_custom_line_item_edittext_name', timeout:10}
		end

		def self.item_price
			{id:'dialog_add_custom_line_item_edittext_price', timeout:10}
		end

		def self.item_taxable
			{id:'dialog_add_custom_line_item_checkbox_taxable', timeout:10}
		end

		def self.item_description
			{id:'dialog_add_custom_line_item_edittext_description', timeout:10}
		end

		def self.add_custom
			{id:'dialog_add_custom_line_item_button_add', timeout:10}
		end

		def self.add_discount
			{id:'activity_estimate_button_add_discount', timeout:10}
		end

		def self.discount_amount
			{id:'dialog_add_discount_edittext_value', timeout:10}
		end
		
		def self.save_discount
			{id:'dialog_add_discount_button_save', timeout:10}
		end
		
		def self.notes
			{id:'activity_estimate_edittext_notes', timeout:10}
		end		

		def self.net_total(netTotal)
			{text:"$#{netTotal}", timeout:10}
		end

	  	def self.tax_amount(tax)
			{text:"$#{tax}", timeout:10}
		end
		
		def self.discount_amount
			{text:'0', timeout:10}
		end
		
		def self.total_amount(amountTotal)
			{text:"$#{amountTotal}", timeout:10}
		end
		
		def self.due_amount(due)
			{text:"$#{due}", timeout:10}
		end
		
		def self.save_estimate
			{id:'activity_estimate_button_save', timeout:10}
		end		
			
		def self.estimate_exists
			{id:'row_estimate_item_textview_customer_name', text:'Total Cost: 30.79', timeout:10}
		end				
							
		def self.spinner
			{id:'dialog_service_agreement_agreement_number_of_systems_spinner', timeout:10}
		end
		
		def self.choose_plan
			{id:'text1', text:'Service Plan', timeout:10}
		end
		
		def self.touch_status
			{id:'activity_add_service_agreement_linearlayout_status', timeout:10}
		end
		
		def self.choose_status
			{id:'text1', text:'ACTIVE', timeout:10}
		end
		
		def self.touch_payment
			{id:'activity_add_service_agreement_linearlayout_payment_type', timeout:10}
		end
		
		def self.choose_payment
			{id:'text1', text:'CASH', timeout:10}
		end	
		
		def self.start_date
			{id:'activity_add_service_agreement_linearlayout_start_date', timeout:10}
		end		
		
		def self.date_picker_save
			{id:'dialog_date_picker_button_save', timeout:10}
		end		
		
		def self.description
			{id:'activity_add_service_agreement_edittext_description', timeout:10}
		end		
		
		def self.salesperson
			{id:'activity_add_service_agreement_edittext_sales_person', timeout:10}
		end
		
		def self.agreement_number
			{id:'activity_add_service_agreement_edittext_agreement_number', timeout:10}
		end
		
		def self.save_all
			{id:'activity_add_service_agreement_button_save', timeout:10}
		end
		
		def self.plan_exists(customer)
			{id:'skedLabel', text:"Service Plan", timeout:10}
		end
		
		def self.plan_detail(customer)
			{id:'activity_service_agreement_textview_agreement_number', text:"#{customer.company_name}", timeout:10}
		end	
		
		def self.btn_back
			{id:'header_button_back', timeout:10}
		end	
				
	end
end


####################################################################################################################
#													IOS															   #
####################################################################################################################

module IOS
	module EstimateScreen
		def self.OK
			'OK'
		end
	
		def self.new
			{type:'button', marked:'Add', index:0, timeout:10}
		end		
		
		def self.service_plan
			'None'
		end	
	
		def self.choose_location(customer)
			"#{customer.address1}, #{customer.address2}, #{customer.city}, AL #{customer.zip_code}"
		end
		
		def self.get_estimate
			{type:'label', index:0, timeout:10}
		end
		
		def self.add_line_item
			{type:'button', marked:'Add Line Item', index:0, timeout:10}
		end		
			
		def self.price_book
			'Price Book'
		end	
		
		def self.custom
			'Custom'
		end	
		
		def self.text
			{text:'6inch Nano Tubing', timeout:10}
		end
		
		def self.view_all
			{type:'view', marked:'View All', index:0, timeout:10}
		end		
		
		def self.air_vent
			{type:'view', marked:'Air Vent', index:0, timeout:10}
		end		
		
		def self.done
			{type:'button', marked:'Done',  timeout:10}
		end
			
		def self.add_one
			{type:'button', marked:'Add 1 Item',  timeout:10}
		end
		
		def self.product_name
			{type:'textField', index:2,  timeout:10}
		end		
				
		def self.description
			{type:'textField', index:1, timeout:10}
		end		
		
		def self.price
			{type:'textField', index:0,  timeout:10}
		end		
		
		def self.quantity
			{type:'textField', index:3,  timeout:10}
		end		
		
		def self.taxable
			{type:'switch', index:0, timeout:10}
		end
		
		def self.add_discount
			{type:'button', marked:'Add Discount', index:0, timeout:10}
		end		
		
		def self.set_discount
			{type:'button', marked:'Set Discount', index:0, timeout:10}
		end		

		def self.discount_field
			{type:'textField', index:0, timeout:10}
		end	
		
		def self.notes
			{type:'textView', index:0, timeout:10}
		end		
		
		def self.net_total(netTotal)
			{text:"$#{netTotal}", timeout:10}
		end

	  	def self.tax_amount(tax)
			{text:"$#{tax}", timeout:10}
		end
		
		def self.discount_amount
			{text:'', timeout:10}
		end
		
		def self.total_amount(amountTotal)
			{text:"$#{amountTotal}", timeout:10}
		end
		
		def self.due_amount(due)
			{text:"$#{due}", timeout:10}
		end

		def self.next
			{type:'button', marked:'Next',  timeout:10}
		end
		
	    def self.save_estimate
			'Save Estimate'
		end	
		
		def self.cancel
			'Cancel'
		end	
		
		def self.plan_exists(customer)
			{marked:"Service Plan #{customer.company_name}", index:0, timeout:10}
		end
		
		def self.plan_detail(customer)
			{marked:"#{customer.company_name}", index:0, timeout:10}
		end
		
		def self.back
			{type:'view', marked:'Back', index:0,  timeout:10}
		end
		
		def self.save
		'Save'
		end
	end	
end