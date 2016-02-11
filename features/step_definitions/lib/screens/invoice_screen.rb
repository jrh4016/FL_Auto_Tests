module Android
	module InvoiceScreen

    def self.address(invoice)
      {type:'textView', text:"#{invoice.billing_location}", timeout:10}
    end
	
		def self.next
			{id:'activity_invoice_button_next', timeout:10}
		end		
		
		def self.save_items
			{id:'header_standard_button_right', timeout:10}
		end		
		
		def self.select(index)
			{text:"#{index}", index:0, timeout:10}
		end	
		
		def self.check(check)
			{text:"$#{check}", timeout:10}
		end
		
		def self.add_line_item
			{id:'activity_invoice_button_add_line_item', timeout:10}
		end

		def self.standard
			{id:'dialog_yes_no_response_button_yes', timeout:10}
		end

		def self.view_all
			{id:'invoiceListItemName', text:'<View All>', timeout:10}
		end
		
		def self.air_tube
			{id:'layout_row_product_name_price_description_text_name', text:'Air Tube', timeout:10}
		end		
		
		def self.add_to_list
			{id:'dialog_layout_add_line_item_button_add', timeout:10}
		end	
		
		def self.quantity
			{id:'dialog_layout_add_line_item_edittext_quantity', timeout:10}
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

    def self.line_item_quantity(index)
      {type:'textView', contentDescription:"line_#{index}_quantity", index:0, timeout:10}
    end

    def self.line_item_details(index)
      {type:'textView', contentDescription:"line_#{index}_details", timeout:10}
    end

    def self.line_item_vat1(index)
      {type:'textView', contentDescription:"line_#{index}_vat1", timeout:10}
    end

    def self.line_item_vat2(index)
      {type:'textView', contentDescription:"line_#{index}_vat2", timeout:10}
    end

    def self.line_item_price(index)
      {type:'textView', contentDescription:"line_#{index}_price", timeout:10}
    end

    def self.line_item_total(index)
      {type:'textView', contentDescription:"line_#{index}_total", timeout:10}
    end

    def self.get_labor_line_number
      {type:'textView', text:'Labor', index:0, timeout:10}
    end

    def self.get_travel_line_number
      {type:'textView', text:'Travel', index:0, timeout:10}
    end

		def self.add_discount
			{id:'activity_invoice_button_add_discount', timeout:10}
    end

    def self.set_discount
      {id:'activity_invoice_button_add_discount', timeout:10}
    end
		
		def self.set_percent_discount
			{id:'dialog_add_discount_imageview_percentage', timeout:10}
		end
		
		def self.set_fixed_discount
			{id:'dialog_add_discount_imageview_dollars', timeout:10}
    end

    def self.discount_field
      {type:'editText', index:0, timeout:10}
    end

    def self.save_discount
			{id:'dialog_add_discount_button_save', timeout:10}
		end
		
		def self.notes
			{id:'activity_invoice_edittext_description', timeout:10}
		end		

		def self.subtotal
			{id:'activity_invoice_textview_net_total', timeout:10}
    end

    def self.discount
      {id:'activity_invoice_textview_discount', timeout:10}
    end

	  def self.tax
			{contentDescription:'tax_value', timeout:10}
		end
		
		def self.total
			{id:'activity_invoice_textview_total', timeout:10}
		end
		
		def self.amount_due
			{id:'activity_invoice_textview_remaining_balance', timeout:10}
    end

    def self.already_paid
      {id:'activity_invoice_textview_payment_history', timeout:10}
    end

    def self.already_paid_text
      {id:'activity_invoice_textview_payment_history', timeout:10}
    end
			
		def self.invoice_exists
			{id:'row_invoice_item_textview_customer_name', text:'Total Cost: 30.79', timeout:10}
		end
		
		def self.complete_invoice
			{id:'activity_invoice_button_complete_invoice', timeout:10}
		end
		
		def self.select_cash
			{id:'activity_payment_options_button_cash', timeout:10}
		end
		
		def self.select_check
			{id:'activity_payment_options_button_check', timeout:10}
		end
		
		def self.check_number
			{id:'activity_payment_options_eddittext_check_number', timeout:10}
		end
		
		def self.select_debit
			{id:'activity_payment_options_button_debit', timeout:10}
		end
		
		def self.select_credit
			{id:'activity_payment_options_button_credit_card', timeout:20}
		end
		
		def self.select_prepaid
			{id:'activity_payment_options_button_prepaid', timeout:10}
    end

    def self.save_payment
      {id:'dialog_split_payment_button_save', timeout:10}
    end

    def self.save_invoice
			{id:'activity_invoice_button_save_invoice', timeout:10}
		end
		
		def self.create_invoice
			{id:'activity_invoice_button_save_invoice', timeout:10}
		end
		
		def self.cancel
			{id:'dialog_split_payment_button_cancel', timeout:10}
		end
		
		def self.skip
			{id:'dialog_primary_email_button_cancel', timeout:10}
		end

		def self.name_on_card														#CREDIT CARD
			{id:'activity_credit_card_payment_edittext_name_on_card', timeout:10}
		end

		def self.card_number
			{id:'activity_credit_card_payment_edittext_card_number', timeout:10}
		end
		
		def self.month_expiration
			{id:'activity_credit_card_payment_edittext_expires_month', timeout:10}
		end
		
		def self.year_expiration
			{id:'activity_credit_card_payment_edittext_expires_year', timeout:10}
		end
		
		def self.cvv
			{id:'activity_credit_card_payment_edittext_cvv', timeout:10}
		end
		
		def self.submit
			{id:'header_standard_button_right',  timeout:10}
    end

		def self.back
      {id:'header_button_back', timeout:10}
    end

    def self.open(invoice)
      {text:"#{invoice.invoice_number}", timeout:10}
    end
	end
end




####################################################################################################################
#													                            IOS															                             #
####################################################################################################################

module IOS
	module InvoiceScreen
    def self.address(invoice)
      {type:'label', text:"#{invoice.billing_location}", timeout:10}
    end

    def self.add_line_item
      {type:'button', marked:'Add Line Item', index:0, timeout:10}
    end

    def self.custom
      'Custom'
    end

    def self.price_book
      'Price Book'
    end

    def self.view_all
			{type:'view', marked:'View All', index:0, timeout:10}
		end		
		
		def self.select(index)
			{text:"#{index}", index:0, timeout:10}
		end

		def self.quantity
			{type:'textField', index:0, timeout:10}
		end
		
		def self.done
			{type:'button', marked:'Done',  timeout:10}
		end
		
		def self.add_one
			{type:'button', marked: 'Add 1 Item',  timeout:10}
    end

    def self.add_mult(num)
      {type:'button', marked:"Add #{num} Items",  timeout:10}
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
		
		def self.custom_quantity
			{type:'textField', index:3,  timeout:10}
		end		
		
		def self.taxable
			{type:'switch', index:0, timeout:10}
    end

    def self.line_item_quantity(index)
      {type:'label', marked:"line_#{index}_quantity", index:0, timeout:10}
    end

    def self.line_item_details(index)
      {type:'label', marked:"line_#{index}_details", timeout:10}
    end

    def self.line_item_vat1(index)
      {type:'label', marked:"line_#{index}_vat1", timeout:10}
    end

    def self.line_item_vat2(index)
      {type:'label', marked:"line_#{index}_vat2", timeout:10}
    end

    def self.line_item_price(index)
      {type:'label', marked:"line_#{index}_price", timeout:10}
    end

    def self.line_item_total(index)
      {type:'label', marked:"line_#{index}_total", timeout:10}
    end

    def self.get_labor_line_number
      {type:'label', text:'Labor', index:0, timeout:10}
    end

    def self.get_travel_line_number
      {type:'label', text:'Travel', index:0, timeout:10}
    end
		
		def self.add_discount
			{type:'button', marked:'Add Discount', index:0, timeout:10}
		end		
		
		def self.set_discount
			{type:'button', marked:'Set Discount', index:0, timeout:10}
    end

    def self.set_percent_discount
      {type:'label', marked:'%', index:0, timeout:10}
    end

    def self.set_fixed_discount
      {type:'label', marked:'$', index:0, timeout:10}
    end

		def self.discount_field
			{type:'textField', index:0, timeout:10}
		end	
		
		def self.save_discount
      {id:'dialog_add_discount_button_save', timeout:10}
    end
		
		def self.notes
			{type:'textView', index:0, timeout:10}
		end		
		
		def self.name_on_card													#CREDIT CARD
			{type:'textField', index:0, timeout:10}
		end

		def self.card_number
			{type:'textField', index:1, timeout:10}
		end
		
		def self.month_expiration
			{type:'textField', index:2, timeout:10}
		end
		
		def self.year_expiration
			{type:'textField', index:6, timeout:10}
		end
		
		def self.cvv
			{type:'textField', index:7, timeout:10}
		end
		
		def self.submit
			{type:'button', marked:'Submit',  timeout:10}
		end
		
		def self.next
			{type:'button', marked:'Next',  timeout:10}
		end

    def self.check_dollar(check)
      {type:'label', text:"$#{sprintf('%.2f', check)}", timeout:10}
    end

    def self.check_subtotal(check)
      {text:"$#{check}", timeout:10}
    end

    def self.check(check)
      {text:"#{check}"}
    end

    def self.subtotal
      {marked:'subtotal', timeout:10}
    end

    def self.tax
      {marked:'tax1', timeout:10}
    end

    def self.discount
      {marked:'discount', timeout:10}
    end

    def self.total
      {marked:'total', timeout:10}
    end

    def self.amount_due
      {marked:'amount due', timeout:10}
    end

    def self.already_paid
      {marked:'already paid', timeout:10}
    end

    def self.already_paid_text
      {marked:'already paid textview', timeout:10}
    end

		def self.back
			{type:'button', marked:'Back', index:0,  timeout:10}
    end

    def self.open(invoice)
      {type:'label', text:"#{invoice.invoice_number}", timeout:10}
    end
	end	
end