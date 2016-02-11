module Android
	module DialogScreen
		def self.OK
			{id:'dialog_switch_yes', timeout:10}
		end
		
		def self.No
			{id:'dialog_switch_no', timeout:10}
		end

		def self.server_url
			{id:'dialog_switch_url', timeout:10}
		end
	end
end

####################################################################################################################
#													IOS															   #
####################################################################################################################

module IOS
	module DialogScreen
		def self.OK
			'OK'
		end

		def self.clear_text
			'Clear text'
		end
		
		def self.server_url
			{view:'UIAlertSheetTextField', text:'https://beta.fieldlocate.com', index:1 , timeout:10}
			#{type:'textField', index:0, timeout:10}
		end
		
	end	
end