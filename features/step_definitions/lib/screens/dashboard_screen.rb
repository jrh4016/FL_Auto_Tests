module Android
	module DashboardScreen
		def self.screen
			{id:'activity_dashboard_button_customers', timeout:10}
		end

		def self.my_schedule
			{id:'activity_dashboard_button_my_schedule', timeout:10}
		end
		
		def self.my_hours
			{id:'activity_dashboard_button_my_hours', timeout:10}
		end
		
		def self.customers
			{id:'activity_dashboard_button_customers', timeout:10}
		end
		
		def self.invoices
			{id:'activity_dashboard_button_invoices', timeout:10}
		end
		
		def self.price_book
			{id:'activity_dashboard_button_pricebook', timeout:10}
		end
		
		def self.part_orders
			{id:'activity_dashboard_button_part_orders', timeout:10}
		end
		
		def self.settings
			{id:'activity_dashboard_button_settings', timeout:10}
		end
		
		def self.help
			{id:'activity_dashboard_button_help', timeout:10}
		end
		
		def self.logout
			{id:'activity_dashboard_button_logout', timeout:10}
		end

    def self.back
      {id:'header_button_back',  timeout:10}
    end
	end
end



####################################################################################################################
#													                            IOS															                             #
####################################################################################################################
module IOS
	module DashboardScreen
		def self.screen
			{type:'view', marked:'Dashboard', timeout:10}
		end
		
		def self.my_schedule
			{type:'button', marked:'My Schedule', timeout:10}
		end
		
		def self.my_hours
			{type:'button', marked:'My Hours', timeout:10}
		end
		
		def self.customers
			{type:'button', marked:'Customers', timeout:10}
		end
		
		def self.invoices
			{type:'button', marked:'Invoices', timeout:10}
		end
		
		def self.price_book
			{type:'button', marked:'Price Book', timeout:10}
    end

		def self.back
      {type:'view', marked:'Back', index:0, timeout:10}
    end
	end	
end