##
# the screen class should only be a translation from screen elements to hashes that represent
# screen elements. From an MVC point of view, its the model.
# elements can be found using - 
# :type, :index, :marked, :id, :text, :enabled, :description, :view, :delay, :strict_wait, :timeout, :contentDescription
# In each screen, its useful to have a #screen method. When this is called, it should return an element that could
# only be found on that screen. We can then check if we are on the correct screen for different tests. Not always
# necessary, but useful.
#
# Note that there is an Android and IOS module. inside each module there is a LoginScreen module.
# this pattern is used, so that MUT, which is defined on the command line, chooses wether the Android or IOS
# module is included. If only one is incuded, we can call LoginScreen.screen, and either the Android or IOS
# methods will be called, as the method from the other module has not even being included in the runtime.

module Android
	module LoginScreen

		def self.screen
			{id:'activity_header', timeout:10} 
		end

		def self.username_field 
			{id:'user_name', timeout:10} 
		end
		
		def self.password_field
			{id:'password', timeout:10}
		end

		def self.login_button
			{id:'login', index:0, timeout:10}
		end

		def self.logo
			{id:'header_imageview_logo', timeout:10}
		end
               
        def self.rate_app
             {id:'rate_us_button_no', timeout:10}
        end
            
        def self.agree
             {id:'dialog_terms_of_service_button_agree', timeout:10}
        end      
               
          def self.elementagree
            	"* id:dialog_terms_of_service_button_agree"
        end              
	end
end


####################################################################################################################
#													IOS															   #
####################################################################################################################

# for iOS useful types are:
# textField, button, label, textView, view, editText, switch, imageButton
module IOS
	module LoginScreen

		def self.screen
			{type:'label', timeout:10, text:'Username'}
		end

		def self.username_field
			{type:'textField', index:0, timeout:10}
		end

		def self.password_field
			{type:'textField', index:1, timeout:10}
		end

		def self.login_button
			{type:'button', marked:'Login', timeout:10}
		end
		
		def self.xAgree
			":view {:marked 'Agree'}"
		end
		
		def self.Agree
			'Agree'
		end
		
		def self.ifAgree
			#:view marked:'Agree'
			{type:'view', marked:'Agree'}
		end
		

		def self.logo
			{marked:'fieldlocate-logo', index:1, timeout:10}
		end

	end
end