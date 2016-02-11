module Android
	module BasicScreen
    def self.check(check)
      {text:"#{check}", index:0, timeout:10}
    end

    def self.touch_text(select)
      {text:"#{select}", index:0, timeout:10}
    end
	end
end



####################################################################################################################
#													                            IOS															                             #
####################################################################################################################
module IOS
	module BasicScreen
    def self.check(check)
      {text:"#{check}", index:0, timeout:10}
    end

    def self.touch_text(select)
      {type:'*', text:"#{select}", index:0, timeout:10}
    end
	end	
end