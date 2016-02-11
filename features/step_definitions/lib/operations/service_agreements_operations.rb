require_relative '../../../support/cal_utils/operations'
module Android
  module ServiceAgreementOperations
    class << self
      include Calabash::CalabashUtils::Operations

      def add(service)
        touch_elem(ServiceAgreementScreen.new)

        touch_elem(ServiceAgreementScreen.choose_service_plan)								                  #SERVICE PLAN
        touch_elem(ServiceAgreementScreen.service_plan_list)
        touch_elem(ServiceAgreementScreen.select(service.type))
        touch_elem(ServiceAgreementScreen.save_service_plan)

        touch_elem(ServiceAgreementScreen.choose_status)									                      #STATUS
        touch_elem(ServiceAgreementScreen.select(service.status))

        touch_elem(ServiceAgreementScreen.choose_payment_type)								                  #PAYMENT TYPE
        touch_elem(ServiceAgreementScreen.select(service.payment_type))

        touch_elem(ServiceAgreementScreen.start_date)										                        #START DATE
        touch_elem(ServiceAgreementScreen.save_date)

        touch_elem(ServiceAgreementScreen.end_date)										                          #END DATE
        year_increment = service.end_date.year - Date.today.year
        (1..year_increment).each { touch_elem(ServiceAgreementScreen.increment_year) }
        touch_elem(ServiceAgreementScreen.save_date)

        set_text_field(ServiceAgreementScreen.description, service.description) 				        #DESCRIPTION
        set_text_field(ServiceAgreementScreen.salesperson, service.salesperson)  	     		      #SALESPERSON
        set_text_field(ServiceAgreementScreen.agreement_number, service.agreement_num) 			    #SERVICE AGREEMENT NUMBER

        locations = query('*', :text)															                              #SELECT LOCATION
        (1..locations.length).each { |inc| touch_elem(ServiceAgreementScreen.select_location(inc-1)) if locations[inc] == service.location }
        touch_elem(ServiceAgreementScreen.save_agreement)
        service.save_to_file
      end

      def check(service)
        touch_elem(ServiceAgreementScreen.service_exists(service)) 						                  #CHECK
        elem_exists? ServiceAgreementScreen.check(service.type)
        elem_exists? ServiceAgreementScreen.check(service.status)
        elem_exists? ServiceAgreementScreen.check(service.payment_type)
        elem_exists? ServiceAgreementScreen.check_description(service.description)
        elem_exists? ServiceAgreementScreen.check("#{service.start_date.strftime($CHECK_DATE_FORMAT)} - #{service.end_date.strftime($CHECK_DATE_FORMAT)}")
        elem_exists? ServiceAgreementScreen.check(service.agreement_num)
        elem_exists? ServiceAgreementScreen.check(service.salesperson)
        touch_elem(ServiceAgreementScreen.back)
      end
	 end
  end
end


####################################################################################################################
#													                            IOS															                             #
####################################################################################################################

module IOS
  module ServiceAgreementOperations
    class << self
      include Calabash::CalabashUtils::Operations
      
      def add(service)
        touch_elem(ServiceAgreementScreen.new)												                          #CREATE NEW

        touch_elem(ServiceAgreementScreen.choose_status)									                      #STATUS
        scroll_row_until_elem("label text:'#{service.status}'", 2, 0)
        touch_elem(ServiceAgreementScreen.select(service.status))
        touch_elem(ServiceAgreementScreen.select(service.status))
        touch_elem(ServiceAgreementScreen.done)

        touch_elem(ServiceAgreementScreen.choose_payment_type)							                    #PAYMENT TYPE
        scroll_row_until_elem("label text:'#{service.payment_type}'", 2, 1)
        touch_elem(ServiceAgreementScreen.select(service.payment_type))
        touch_elem(ServiceAgreementScreen.select(service.payment_type))
        touch_elem(ServiceAgreementScreen.done)

        touch_elem(ServiceAgreementScreen.choose_service_plan)							                    #SERVICE PLAN
        scroll_row_until_elem("label text:'#{service.type}'", 2, 2)
        touch_elem(ServiceAgreementScreen.select(service.type))
        touch_elem(ServiceAgreementScreen.select(service.type))
        touch_elem(ServiceAgreementScreen.done)

        set_text_field(ServiceAgreementScreen.description, service.description)                 #DESCRIPTION

        touch_elem(ServiceAgreementScreen.start_date)										                        #START DATE
        query('datePicker', setDate:service.start_date.next_day.to_datetime)
        touch_elem(ServiceAgreementScreen.done)

        touch_elem(ServiceAgreementScreen.end_date)										                          #END DATE
        query('datePicker', setDate:service.end_date.next_day.to_datetime)
        touch_elem(ServiceAgreementScreen.done)

        set_text_field(ServiceAgreementScreen.agreement_number, service.agreement_num) 	        #SERVICE AGREEMENT NUMBER
        set_text_field(ServiceAgreementScreen.salesperson, service.salesperson) 				        #SALESPERSON
        touch_elem(ServiceAgreementScreen.done)

        touch_elem(ServiceAgreementScreen.select(service.location)) 				                    #SELECT LOCATION
        touch_elem(ServiceAgreementScreen.submit)
        service.save_to_file
      end

      def check(service)
        touch_elem(ServiceAgreementScreen.service_exists(service)) 				                      #CHECK
        elem_exists? ServiceAgreementScreen.check(service.status)
        elem_exists? ServiceAgreementScreen.check(service.payment_type)
        elem_exists? ServiceAgreementScreen.check(service.type)
        elem_exists? ServiceAgreementScreen.check_description(service.description)
        elem_exists? ServiceAgreementScreen.check_date(service.start_date)
        elem_exists? ServiceAgreementScreen.check_date(service.end_date)
        elem_exists? ServiceAgreementScreen.check(service.agreement_num)
        elem_exists? ServiceAgreementScreen.check(service.salesperson)
        touch_elem(ServiceAgreementScreen.back)
      end
    end
  end
end