module Android
	module HistoryScreen
		def self.screen
			{type:'view', marked:'Customer History', timeout:10}
		end
		
		def self.check(check)
			{text:"#{check}", index:0, timeout:10}
		end
		
		def self.done
			{type:'view', marked:"Done", index:0,  timeout:10}
		end
		
		def self.submit
			{type:'button', marked:"Submit", index:0,  timeout:10}
		end
		
	end	
end

####################################################################################################################
#													                          IOS															                               #
####################################################################################################################

module IOS
	module HistoryScreen
		def self.screen
			{type:'view', marked:'Customer History', timeout:10}
		end
		
		def self.select(sel)
			{text:"#{sel}", index:0, timeout:10}
		end
		
		def self.check(check)
			{text:"#{check}", index:0, timeout:10}
		end
		
		def self.done
			{type:'view', marked:"Done", index:0,  timeout:10}
		end
		
		def self.submit
			{type:'button', marked:"Submit", index:0,  timeout:10}
		end
		
	end	
end