require_relative '../../../support/cal_utils/operations'

##
# Welcome to the operations module!
# This is where all our hard work and heavy lifting will be done. From an MVC, this is the controller.
# Here we should be able to get/set fields, check text etc. However, we should never do assertions in this 
# module. Assertions should be left to the step definitions. We can get the values needed for assertions, 
# but the assert code left to the step files.
#
# Note that there is an Android and IOS module. inside each module there is a LoginOperations module.
# this pattern is used, so that MUT, which is defined on the command line, chooses wether the Android or IOS
# module is included. If only one is incuded, we can call LoginScreen.screen, and either the Android or IOS
# methods will be called, as the method from the other module has not even being included in the runtime.
#
# As well as having a LoginOperations module, each module has a class << self, which makes the methods static
# class methods, instead of module methods. Reason for this, is calabash is made available to class level objects
# if this was left as a normal module, we would either have to include it into a class to use it, or reference
# the calabash methods via static references, which is a lot of typing.

module Android
	module LoginOperations
		class << self
			include Calabash::CalabashUtils::Operations

			def login(username)
        unless element_exists("* id:'activity_dashboard_button_customers'")
          set_text_field(LoginScreen.username_field, username)
          set_text_field(LoginScreen.password_field, username)

          touch_elem(LoginScreen.login_button)
          sleep 1
          if element_exists("* marked:'Agree'")
            touch_elem(LoginScreen.agree)
          end
          sleep 3
          unless element_exists("* id:'activity_dashboard_button_customers'")
            touch_elem(LoginScreen.login_button)
          end

          sleep 0.5
          if element_exists("* marked:'Yes!'")
            #if elem_exists?(LoginScreen.rate_app)
            touch_elem(LoginScreen.rate_app)
          end
        end
			end
		end
	end
end


####################################################################################################################
#													                          IOS															                               #
####################################################################################################################

module IOS
	module LoginOperations
		class << self
			include Calabash::CalabashUtils::Operations
			
			def login(username)
        unless element_exists("view marked:'Dashboard'")
          set_text_field(LoginScreen.username_field, username)
          set_text_field(LoginScreen.password_field, username)

          if uia_element_exists?(:view, marked: 'Agree')
            uia_tap_mark(LoginScreen.Agree)
            end
          wait_for_elements_exist(["view marked:'Dashboard'"], :timeout => 10)
        end
      end
		end
	end
end