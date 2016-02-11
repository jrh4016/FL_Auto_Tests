require_relative '../../../support/cal_utils/operations'
require_relative '../screens/customers_screen'
require_relative '../screens/history_screen'


module Android
  module HistoryOperations 
    class << self
      include Calabash::CalabashUtils::Operations
      
      def check(appointment)
        elem_exists? HistoryScreen.check(appointment.type)
        elem_exists? HistoryScreen.check(appointment.day)
        elem_exists? HistoryScreen.check(appointment.type)
        #elem_exists? HistoryScreen.check(appointment.day_num)
        touch("textView text:'#{appointment.a_start} - #{appointment.a_end}'")
        elem_exists? HistoryScreen.check('Completed')
        #raise('APPOINTMENT FULL STRING IS WRONG') unless element_exists("* text:'#{appointment.full_string}'")
      end
    end
  end
end


####################################################################################################################
#													                          IOS															                               #
####################################################################################################################

module IOS
  module HistoryOperations 
    class << self
      include Calabash::CalabashUtils::Operations
      
      def check(appointment)
        wait_for_none_animating
        elem_exists? (HistoryScreen.check(appointment.time_address))
        elem_exists? HistoryScreen.check(appointment.day)
        elem_exists? HistoryScreen.check(appointment.day_num)
        touch_elem(HistoryScreen.select(appointment.time_address))
      end
    end
  end
end