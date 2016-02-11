module StepsDataCache
	class << self
		attr_accessor :cache
		
		def cache
			@cache.nil? ? @cache={} : @cache
		end
	end
end