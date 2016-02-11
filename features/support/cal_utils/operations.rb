require_relative('./cal_utils')
require 'calabash-android/operations'
require 'calabash-cucumber/operations'
module Calabash
	module CalabashUtils
		module Operations
			if ENV['MUT'] == 'AND'
		    include Calabash::Android::Operations
		  else
		    include Calabash::Cucumber::Operations
		  end

			def get_elem(filters)
				CalUtils.new.get_elem filters
			end

			def get_elems(filters)
				CalUtils.new.get_elems filters
			end

			def get_label(filters)
				CalUtils.new.get_label filters
			end

			def get_labels(filters)
				CalUtils.new.get_labels filters
			end

			def elem_exists?(filters)
				!CalUtils.new.get_elems(filters).empty?
			end

			def touch_elem(filters_or_elem)
        elem = get_elem(filters_or_elem)
        wait_for_none_animating if ENV['MUT'] == 'IOS'
				touch(elem) 
			end

			def set_text_field(filters, text)
				CalUtils.new.set_text_field(filters, text)
			end

			def scroll_view(direction)
				CalUtils.new.scroll_view(direction)
			end

			def scroll_until_elem(filters, direction)
				CalUtils.new.scroll_until_elem(filters, direction)
      end

      def scroll_row_until_elem(query_text, row_inc, index_num)
        CalUtils.new.scroll_row_until_elem(query_text, row_inc, index_num)
      end

			def search_list_for(name)
				CalUtils.new.search_list_for name
			end

			def get_elem_attr(filters, attribute)
				CalUtils.new.get_elem_attr(filters, attribute)
			end

			def go_back
				CalUtils.new.go_back
			end
			    		
			def time_interval(time_str)	
				time = Time.parse(time_str)
  				# normalize to zero
  				time = time - time.sec
  				minute = time.min
  				count = 0
  				interval = 60
  				unless (minute % interval) == 0
   				  	begin
     				 minute = (minute > 59) ? 0 : minute + 1
      				count = count + 1
    			  end
  			end while ((minute % interval) != 0)
  			time = time + (count * 60)
			end
			
			def date_picker(hour)
		 		CalUtils.new.date_picker(hour)
			end

      def dollar(text)
        "$#{sprintf('%.2f', text)}"
      end

		end
	end
end