module Android
	module MyScheduleScreen
		def self.back
			{id:'header_button_back', timeout:10}
		end
		
		def self.select_appointment(num)
			{type:'textView', index:"#{num}", timeout:10}
		end
		
		def self.check(check)
			{text:"#{check}", timeout:10}
		end
	end	
end



####################################################################################################################
#													IOS															   #
####################################################################################################################

module IOS
	module MyScheduleScreen
		def self.btn_back
			{id:'btn_back', timeout:10}
		end
		
		def self.select_appointment(num)
			{type:'label', index:"#{num+3}", timeout:10}
		end
		
		def self.check(check)
			{marked:"#{check}", index:0, timeout:10}
		end
	end	
end