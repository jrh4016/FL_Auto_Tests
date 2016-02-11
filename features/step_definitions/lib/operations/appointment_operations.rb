require_relative '../../../support/cal_utils/operations'
require_relative '../screens/customers_screen'
require_relative '../screens/appointment_screen'

require 'date'
require 'time'

module Android
  module AppointmentOperations 
    class << self
      include Calabash::CalabashUtils::Operations

      ##########################################################
      #		  		        AND CREATE APPOINTMENT	  	 			     #
      ##########################################################
      def create(appointment)
        touch_elem(NewAppointmentScreen.choose_location)						                                      #SELECT LOCATION
        touch_elem(NewAppointmentScreen.select(appointment.location))

        touch_elem(NewAppointmentScreen.choose_appointment_type)			                                    #APPOINTMENT TYPE
        touch_elem(NewAppointmentScreen.select(appointment.type))
        touch_elem(NewAppointmentScreen.save_appointment_type)


        touch_elem(NewAppointmentScreen.set_start_date)							                                      #START DATE
        next_day = 0
        until appointment.time.to_date == (Date.today + next_day)
          touch_elem(NewAppointmentScreen.increment_day)
          next_day += 1
        end
        touch_elem(NewAppointmentScreen.select_start_hour)
        until element_exists("* text:'#{appointment.s_start}'") do
          performAction('scroll_down')
          sleep 0.25
        end
        touch_elem(NewAppointmentScreen.select_time(appointment.s_start))
        touch_elem(NewAppointmentScreen.save)

        touch_elem(NewAppointmentScreen.set_end_date)								                                      #END DATE
        touch_elem(NewAppointmentScreen.select_end_hour)
        touch_elem(NewAppointmentScreen.select_time(appointment.s_end))
        touch_elem(NewAppointmentScreen.save)

        set_text_field(NewAppointmentScreen.notes, appointment.note)	                                #NOTES
        touch_elem(NewAppointmentScreen.save)									                                            #SAVE
        wait_for_elements_exist(["frameLayout id:'fragment_customer_list_container'"], :timeout => 10)
        appointment.save_to_file
      end

      ##########################################################
      #		  		           AND ADD EQUIPMENT    	  		 	     #
      ##########################################################
      def add_equipment(equipment)
        touch_elem(AppointmentScreen.select(equipment.name))
        touch_elem(AppointmentScreen.save_equipment)
        wait_for_elements_exist( ["textView id:'activity_appointment_textview_appointment_status'"], :timeout => 10)
        performAction('scroll_down')
        sleep 0.25
        raise("DID NOT FIND EQUIPMENT #{equipment.manufacturer} #{equipment.name} ON APPOINTMENT") if element_exists("label text:'#{equipment.manufacturer} #{equipment.name}'")
      end


      ##########################################################
      #		  		      AND ADD SERVICE AGREEMENT		  	 	       #
      ##########################################################
      def add_service_agreement(service)
        touch_elem(AppointmentScreen.select("#{service.type}"))
        sleep 0.25
        touch_elem(AppointmentScreen.save_agreement)
        sleep 0.5
        performAction('scroll_down')
        elem_exists? AppointmentScreen.select("#{service.type}\n#{service.description}")
        scroll_view(:up)
      end

      ##########################################################
      #		  		          AND UPDATE STATUS	  	 			         #
      ##########################################################
      def update_status(appointment)
        touch_elem(AppointmentScreen.status)
        touch_elem(AppointmentScreen.select('En Route'))
        appointment.status = 'On Route'

        touch_elem(AppointmentScreen.status)
        touch_elem(AppointmentScreen.select('Begin Work'))
        appointment.status = 'Working'

        touch_elem(AppointmentScreen.status)
        touch_elem(AppointmentScreen.select('Parts Run'))
        appointment.status = 'Parts Run'

        touch_elem(AppointmentScreen.status)
        touch_elem(AppointmentScreen.select('Resume'))
        appointment.status = 'Working'

        touch_elem(AppointmentScreen.status)
        touch_elem(AppointmentScreen.select('Work Finished'))
        appointment.status = 'Finished'

        if appointment.type == 'Intimidation'                                                         #ANSWER QUESTIONS
          touch_elem(AppointmentScreen.question1)
          touch_elem(AppointmentScreen.yes)
          touch_elem(AppointmentScreen.confirm)

          touch_elem(AppointmentScreen.question2)
          touch_elem(AppointmentScreen.no)
          touch_elem(AppointmentScreen.confirm)

          touch_elem(AppointmentScreen.save_questions)
        end
        wait_for_elements_exist(["textView text:'Invoice no. '"], :timeout => 10)
      end
    end
  end
end


####################################################################################################################
#													                          IOS															                               #
####################################################################################################################


module IOS
  module AppointmentOperations
    class << self
      include Calabash::CalabashUtils::Operations

      ##########################################################
      #		  		        IOS CREATE APPOINTMENT	  	 			     #
      ##########################################################
      def create(appointment)
        touch_elem(NewAppointmentScreen.choose_location)                                              #SELECT LOCATION
        scroll_row_until_elem("label text:'#{appointment.location}' index:1", 1, 0)
        touch_elem(NewAppointmentScreen.select(appointment.location))
        touch_elem(NewAppointmentScreen.select(appointment.location))


        touch_elem(NewAppointmentScreen.choose_appointment_type)		                             		  #SELECT APPOINTMENT TYPE
        touch_elem(NewAppointmentScreen.select(appointment.type))
        touch_elem(NewAppointmentScreen.select(appointment.type))
        touch_elem(NewAppointmentScreen.done)

        touch_elem(NewAppointmentScreen.start_date)							                                      #START DATE AND TIME
        query('datePicker', setDate:appointment.time.to_datetime)
        touch_elem(NewAppointmentScreen.done)

        touch_elem(NewAppointmentScreen.end_date)									                                    #END DATE AND TIME
        scroll_to_row('tableView index:0', 3)
        touch_elem(NewAppointmentScreen.done)

        set_text_field(NewAppointmentScreen.notes, appointment.note)                                  #SET NOTE
        touch_elem(NewAppointmentScreen.done)
        touch_elem(NewAppointmentScreen.submit)                                                       #SUBMIT
        wait_for_elements_exist(["view marked:'Dashboard'"], :timeout => 10)
        appointment.save_to_file
        appointment.time_address[6] = appointment.time_address[6].upcase
        appointment.a_start[1] == ':'? appointment.time_address[5]  = appointment.time_address[5].upcase : appointment.time_address[7]  = appointment.time_address[7].upcase
      end

      ##########################################################
      #		  			          IOS CHANGE NOTE    	  		         #
      ##########################################################
      def change_note(appointment)
        keyboard_enter_text " Don't forget the wrench"
        appointment.note << " Don't forget the wrench"
        touch_elem(AppointmentScreen.done)
        touch_elem(AppointmentScreen.submit)
        sleep 0.25
        raise('ERROR - APPOINTMENT ALREADY EXISTS') if element_exists("label marked:'Error'")
        wait_for_elements_exist(["label marked:'Press to Update Status'"], :timeout => 5)
        scroll('scrollView', :down)
        sleep 0.25
        scroll('scrollView', :down)
        sleep 0.25
        raise('APPOINTMENT NOTE CHANGE NOT FOUND') unless (query 'textView index:0', :text)[0] == appointment.note
        scroll('scrollView', :up)
      end

      ##########################################################
      #		  			         IOS ADD EQUIPMENT    	  		       #
      ##########################################################
      def add_equipment(equipment)
        sleep 0.25
        if element_exists("* marked:'More info, #{equipment.name}, #{equipment.serial_num}'") || element_exists("* marked:'More info'")
          touch_elem(AppointmentScreen.back)
        else
          touch_elem(AppointmentScreen.select(equipment.name))
          touch_elem(AppointmentScreen.submit)
        end
        wait_for_elements_exist(["label marked:'Press to Update Status'"], :timeout => 5)
        uia_scroll_to :view, marked:'Notes from Dispatch'
        raise("DID NOT FIND EQUIPMENT #{equipment.manufacturer} #{equipment.name} ON APPOINTMENT") unless element_exists("label text:'#{equipment.manufacturer} #{equipment.name}'")
      end


      ##########################################################
      #		  		       IOS ADD SERVICE AGREEMENT		  	       #
      ##########################################################
      def add_service_agreement(service)
        touch_elem(AppointmentScreen.select("#{service.type} #{service.description}"))
        uia_tap_mark('Add Agreement to the Appointment')
        wait_for_elements_exist(["label marked:'Press to Update Status'"], :timeout => 5)
        uia_scroll_to :view, marked: 'Notes from Dispatch'
        raise("DID NOT FIND SERVICE AGREEMENT #{service.type} #{service.description} ON APPOINTMENT") unless element_exists("label text:'#{service.type} #{service.description}'")
        uia_scroll_to :view, marked: 'Not Started'
      end


      ##########################################################
      #		  			        IOS UPDATE STATUS		  		           #
      ##########################################################
      def update_status(appointment)
        touch_elem(AppointmentScreen.not_started)     				                                        #EN ROUTE
        uia_tap_mark('En Route')
        appointment.status = 'On Route'

        touch_elem(AppointmentScreen.en_route)					                                              #BEGIN WORK
        uia_tap_mark('Begin Work')
        appointment.status = 'Working'

        touch_elem(AppointmentScreen.working)					                                                #PARTS RUN
        uia_tap_mark('Parts Run')
        appointment.status = 'Parts Run'

        touch_elem(AppointmentScreen.parts_run)				                                                #CONTINUE WORK
        uia_tap_mark('Continue Work')

        touch_elem(AppointmentScreen.working)				                                                  #WORK FINISHED
        uia_tap_mark('Work Finished')
        appointment.status = 'Finished'
        uia_tap_mark('OK')

        if appointment.type == 'Intimidation'                                                         #ANSWER QUESTIONS
          wait_for_none_animating
          touch("label text:'Is there anyone left?' index:0")
          uia_tap_mark('Yes')

          wait_for_none_animating
          touch("label text:'Will anyone return to this area?' index:0")
          uia_tap_mark('Yes')

          touch_elem(AppointmentScreen.submit)
          uia_tap_mark('Open Invoice')
        end
		  end
    end
  end
end