require_relative '../../../support/cal_utils/operations'
module Android
  module EstimateOperations
    class << self
      include Calabash::CalabashUtils::Operations

		#############################
		#	   CREATE ESTIMATE		#
		#############################
		def create_estimate()
		
			 netTotal = 0
			 tax = 0
		     touch_elem(EstimateScreen.add_line_item())							#ADD LINE ITEM
		     touch_elem(EstimateScreen.standard()) 							#STANDARD
		     touch_elem(EstimateScreen.view_all())   							#VIEW ALL
		     touch_elem(EstimateScreen.air_vent())     							#AIR VENTS
		     touch_elem(EstimateScreen.add_to_list())
		     touch_elem(EstimateScreen.save())
			 set_text_field(EstimateScreen.notes, "Estimate #"+SecureRandom.hex[0..4])		
			 
			 tax = netTotal * 0.1														#MATH
	         tax = tax.round(2)
	         amountTotal = netTotal + tax
	         due = amountTotal       
		     		     
		 	 elem_exists? EstimateScreen.tax_amount(sprintf('%.2f', tax))				#CHECK
	         elem_exists? EstimateScreen.net_total(sprintf('%.2f', netTotal))         
	         elem_exists? EstimateScreen.total_amount(sprintf('%.2f', amountTotal)) 
	         elem_exists? EstimateScreen.due_amount(sprintf('%.2f', due)) 
	 	         
		     touch_elem(EstimateScreen.save())									#SAVE
		     touch_elem(EstimateScreen.save_estimate())
		     touch_elem(EstimateScreen.save())
		     sleep 5         
		end		
		
		#############################
	    #	     Add Custom	   	    #
	    #############################
	    def add_custom()
			price = rand(10.00..30.00).round(2)
			discount = rand(1..4) * 5
			netTotal = 30 + price
			tax = (netTotal - discount) * 0.1
			tax = tax.round(2)
			amountTotal = netTotal - discount + tax
			due = amountTotal


			touch_elem(EstimateScreen.add_line_item())
		    touch_elem(EstimateScreen.custom())
			set_text_field(EstimateScreen.item_name, "6 inch nano tubing")			     	     	     	     	     	     	     	     	     	     	     	     	     	     
		 	set_text_field(EstimateScreen.item_price, price)	   
		 	#touch_elem(EstimateScreen.item_price()))
		 	#keyboad_enter_text(price)  	     	     	     	          	     
		    touch_elem(EstimateScreen.item_taxable())
			set_text_field(EstimateScreen.item_description, "Tiny tubing to inject steam")	
		    touch_elem(EstimateScreen.add_custom())
		    
		    touch_elem(EstimateScreen.add_discount())
			set_text_field(EstimateScreen.discount_amount, discount)		     
		    touch_elem(EstimateScreen.save_discount())
			 
			elem_exists? EstimateScreen.tax_amount(sprintf('%.2f', tax))
			elem_exists? EstimateScreen.net_total(sprintf('%.2f', netTotal))         
			elem_exists? EstimateScreen.total_amount(sprintf('%.2f', amountTotal)) 
			elem_exists? EstimateScreen.due_amount(sprintf('%.2f', due)) 
	    	touch_elem(EstimateScreen.save())
		    touch_elem(EstimateScreen.save_estimate())
		    touch_elem(EstimateScreen.save())
		    sleep 5
	   	end
	 end
  end
end






####################################################################################################################
#													IOS															   #
####################################################################################################################

module IOS
  module EstimateOperations
    class << self
      include Calabash::CalabashUtils::Operations
      
		#############################
		#	   CREATE ESTIMATE		#
		#############################
		def create_estimate()
			netTotal = 0
			tax = 0
 
	        touch_elem(EstimateScreen.add_line_item())				#ADD LINE ITEM
	        uia_tap_mark(EstimateScreen.price_book)	         			#PRICE BOOK
	        touch_elem(EstimateScreen.view_all())						#VIEW ALL
	        touch_elem(EstimateScreen.air_vent())	  					#AIR VENT
	        touch_elem(EstimateScreen.done())
	        touch_elem(EstimateScreen.add_one())     	 			#ADDED
	         
	         
	        netTotal = netTotal + 30  										#MATH
	        tax = netTotal * 0.1
	        tax = tax.round(2)
	        amountTotal = netTotal + tax
	        due = amountTotal        
		         
	         
	        set_text_field(EstimateScreen.notes, "Estimate #" + SecureRandom.hex[0..4]) 			
	        touch_elem(EstimateScreen.done())
	         
	        #elem_exists? EstimateScreen.tax_amount(sprintf('%.2f', tax))
	        elem_exists? EstimateScreen.net_total(sprintf('%.2f', netTotal))         
	        elem_exists? EstimateScreen.total_amount(sprintf('%.2f', amountTotal)) 
	        elem_exists? EstimateScreen.due_amount(sprintf('%.2f', due)) 
	        touch_elem(EstimateScreen.next())
	        uia_tap_mark(EstimateScreen.save_estimate)
	        if element_exists("* accessibilityLabel:'OK' index:0")
				uia_tap_mark('OK')
			end
	        sleep 5
	   end
	   
	   
	   #############################
	   #		ADD CUSTOM		   #
	   #############################
	   def add_custom()
			#touch_elem(EstimateScreen.get_estimate))

			price = rand(10.00..30.00).round(2)
			discount = rand(1..4) * 5
			netTotal = 30 + price
			tax = (netTotal - discount) * 0.1
			tax = tax.round(2)
			amountTotal = netTotal - discount + tax
			due = amountTotal
			
			touch_elem(EstimateScreen.add_line_item())
			uia_tap_mark(EstimateScreen.custom)	             
			set_text_field(EstimateScreen.product_name, "6inch Nano Tubing") 	  
			#set_text_field(EstimateScreen.price, price) 
			touch_elem(EstimateScreen.price())
	 		keyboard_enter_text(price.to_s) 
			set_text_field(EstimateScreen.description, "Tiny tubing used to inject steam") 			 
			touch_elem(EstimateScreen.done())
			
			touch_elem(EstimateScreen.add_discount())
			#set_text_field(EstimateScreen.discount_field, discount)		
			touch_elem(EstimateScreen.discount_field)
			keyboard_enter_text(discount.to_s)
 			touch_elem(EstimateScreen.done())
 			
 			set_text_field(EstimateScreen.notes, "+ custom and discount") 			
	        touch_elem(EstimateScreen.done())
			
			#elem_exists? EstimateScreen.tax_amount(sprintf('%.2f', tax))
			elem_exists? EstimateScreen.net_total(sprintf('%.2f', netTotal))         
			elem_exists? EstimateScreen.total_amount(sprintf('%.2f', amountTotal)) 
			elem_exists? EstimateScreen.due_amount(sprintf('%.2f', due))
							       		
			touch_elem(EstimateScreen.next())
			uia_tap_mark(EstimateScreen.save_estimate)
			uia_tap_mark('OK')
			sleep 5
	   end
    end
  end
end