module Android
	module NavigationOperations
		class << self
			include Calabash::CalabashUtils::Operations

			def connect_beta_server
				if element_exists("* id:'activity_header', timeout:10")
					(0..5).each { touch_elem(LoginScreen.logo) }
          sleep 0.5
					test = query('* index:10', :text)[0]
          sleep 1
					if test == '(Production)'
						set_text_field(DialogScreen.server_url, TestConfig.server_url)
						touch_elem(DialogScreen.OK)
          else
						touch_elem(DialogScreen.No)
          end
				end
      end

      def goto(screen)
        case screen.downcase
          ################################
          #		    DEFAULT DASHBOARD		   #
          ################################
          when 'dashboard my schedule'
            touch_elem(DashboardScreen.my_schedule)
          when 'dashboard my hours'
            touch_elem(DashboardScreen.my_hours)
          when 'dashboard customers'
            touch_elem(DashboardScreen.customers)
          when 'dashboard invoices'
            touch_elem(DashboardScreen.invoices)
          when 'dashboard price book'
            touch_elem(DashboardScreen.price_book)

          ################################
          #	      CUSTOMER DASHBOARD		 #
          ################################
          when 'customer locations'
            touch_elem(CustomersScreen.locations)
          when 'customer equipment'
            touch_elem(CustomersScreen.equipment)
          when 'customer new appointment'
            touch_elem(CustomersScreen.new_appointment)
          when 'customer history'
            touch_elem(CustomersScreen.history)
          when 'customer service agreements'
            touch_elem(CustomersScreen.service_agreement)
          when 'customer add phone'
            touch_elem(CustomersScreen.add_phone)
          when 'customer add email'
            uia_scroll_to :view, marked:'Email Addresses'
            touch_elem(CustomersScreen.add_email)
          when 'customer customer note'
            uia_scroll_to :view, marked:'Customer Notes'
            touch_elem(CustomersScreen.add_note)

          ################################
          #	    APPOINTMENT DASHBOARD	   #
          ################################

          when 'appointment invoice'
            touch_elem(AppointmentScreen.invoice)
          when 'appointment estimate'
            touch_elem(AppointmentScreen.estimate)
          when 'appointment view comments'
            touch_elem(AppointmentScreen.view_comments)
          when 'appointment photo gallery'
            touch_elem(AppointmentScreen.photo_gallery)
          when 'appointment on truck'
            touch_elem(AppointmentScreen.on_truck)
          when 'appointment add equipment'
            touch_elem(AppointmentScreen.add_equipment)
          when 'appointment photo gallery'
            touch_elem(AppointmentScreen.photo_gallery)
          when 'appointment capture photo'
            touch_elem(AppointmentScreen.capture_photo)
          when 'appointment add service agreement'
            touch_elem(AppointmentScreen.add_service_agreement)
          when 'appointment part orders'
            touch_elem(AppointmentScreen.part_orders)
          else
            raise('Screen name not recognized. valid screens: customers, locations')
        end
      end

      def go_back
        sleep 0.5
        performAction('go_back')
        sleep 0.5
      end

      def touch_text(entry)
        touch_elem(BasicScreen.touch_text(entry))
      end

      def open_invoice(entry)
        touch_elem(BasicScreen.touch_text("Invoice: #{entry}"))
      end
		end
	end
end


####################################################################################################################
#													IOS															   #
####################################################################################################################

module IOS
	module NavigationOperations
		class << self
			include Calabash::CalabashUtils::Operations

			def connect_beta_server
				if element_exists("* marked:'fieldlocate-logo' index:1")
					(0..4).each { touch_elem(LoginScreen.logo) }
					touch 'button index:2'
					keyboard_enter_text(TestConfig.server_url)
					
					uia_tap_mark(DialogScreen.OK)
        end
      end

      def goto(screen)
        case screen.downcase
          ################################
          #		    DEFAULT DASHBOARD		   #
          ################################
          when 'dashboard my schedule'
            touch_elem(DashboardScreen.my_schedule)
          when 'dashboard hours'
            touch_elem(DashboardScreen.my_hours)
          when 'dashboard customers'
            touch_elem(DashboardScreen.customers)
          when 'dashboard invoices'
            touch_elem(DashboardScreen.invoices)
          when 'dashboard price book'
            touch_elem(DashboardScreen.price_book)

          ################################
          #	     CUSTOMER DASHBOARD		   #
          ################################
          when 'customer locations'
            touch_elem(CustomersScreen.locations)
          when 'customer equipment'
            touch_elem(CustomersScreen.equipment)
          when 'customer new appointment'
            touch_elem(CustomersScreen.new_appointment)
          when 'customer history'
            touch_elem(CustomersScreen.history)
          when 'customer service agreements'
            touch_elem(CustomersScreen.service_agreement)
          when 'customer add phone'
            touch_elem(CustomersScreen.add_phone)
          when 'customer add email'
            uia_scroll_to :view, marked:'Email Addresses'
            touch_elem(CustomersScreen.add_email)
          when 'customer customer note'
            uia_scroll_to :view, marked:'Customer Notes'
            touch_elem(CustomersScreen.add_note)

          ################################
          #	    APPOINTMENT DASHBOARD		 #
          ################################

          when 'appointment invoice'
            touch_elem(AppointmentScreen.invoice)
          when 'appointment estimate'
            touch_elem(AppointmentScreen.estimate)
          when 'appointment notes'
            touch_elem(AppointmentScreen.appointment_notes)
          when 'appointment photo gallery'
            touch_elem(AppointmentScreen.photo_gallery)
          when 'appointment on truck'
            touch_elem(AppointmentScreen.on_truck)
          when 'appointment add equipment'
            touch_elem(AppointmentScreen.add_equipment)
          when 'appointment photo gallery'
            touch_elem(AppointmentScreen.photo_gallery)
          when 'appointment capture photo'
            touch_elem(AppointmentScreen.capture_photo)
          when 'appointment add service agreement'
            touch_elem(AppointmentScreen.add_service_agreement)
          when 'appointment part orders'
            touch_elem(AppointmentScreen.part_orders)
          else
            raise('Screen name not recognized. valid screens: customers, locations')
        end
      end

      def go_back
        touch_elem(DashboardScreen.back)
      end

      def touch_text(entry)
        touch_elem(BasicScreen.touch_text(entry))
      end

      def open_invoice(entry)
        touch_elem(BasicScreen.touch_text(entry))
      end
		end
	end
end