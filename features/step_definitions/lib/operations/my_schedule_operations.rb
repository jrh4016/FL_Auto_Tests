require_relative '../../../support/cal_utils/operations'
require_relative '../screens/customers_screen'
require_relative '../screens/appointment_screen'


module Android
  module MyScheduleOperations 
    class << self
      include Calabash::CalabashUtils::Operations
      
      def open(appointment)
        wait_for_elements_exist( ["imageView id:'nav_appointment_imageview_nav_active'"], :timeout => 5)
        appointments = query 'textView', :text
        inc = 0
        until 0 == 1
          break if appointments[inc] == appointment.a_start && appointments[inc+5] == appointment.day && appointments[inc+6] == appointment.day_num
          inc+=1
          if inc >= appointments.length
            performAction('scroll_down')
            sleep 1
            appointments = query 'textView', :text
            raise("NO APPOINTMENT FOUND #{appointment.day} - #{appointment.day_num} - #{appointment.time_address}") if appointments.length < 2
            inc = 0
          end
        end
        touch_elem(MyScheduleScreen.select_appointment(inc))
        wait_for_elements_exist( ["textView id:'activity_appointment_textview_appointment_status'"], :timeout => 5)
        raise("LOCATION NOT FOUND ON APPOINTMENT - #{appointment.location}") unless element_exists("textView text:'#{appointment.location}'")
        raise('APPOINTMENT FULL STRING IS WRONG') unless element_exists("* text:'#{appointment.full_string}'")
      end
    end
  end
end


####################################################################################################################
#													                          IOS															                               #
####################################################################################################################

module IOS
  module MyScheduleOperations 
    class << self
      include Calabash::CalabashUtils::Operations
      
      def open(appointment)
        wait_for_none_animating
        appointments = query 'label', :text
        inc = 0
        until 0 == 1
          break if appointments[inc] == appointment.day && appointments[inc+1] == appointment.day_num && appointments[inc+3] == appointment.time_address
          inc+=1
          if inc >= appointments.length
            scroll('tableView index:0', :down)
            sleep 0.4
            appointments = query 'label', :text
            raise("NO APPOINTMENT FOUND #{appointment.day} - #{appointment.day_num} - #{appointment.time_address}") if appointments.length < 2
            inc = 0
          end
        end
        touch_elem(MyScheduleScreen.select_appointment(inc))
        wait_for_elements_exist( ["label marked:'Press to Update Status'"], :timeout => 5)
        raise("LOCATION NOT FOUND ON APPOINTMENT - #{appointment.location}") unless element_exists("label text:'#{appointment.location}'")
        raise('APPOINTMENT FULL STRING IS WRONG') unless element_exists("* text:'#{appointment.full_string}'")
      end
    end
  end
end