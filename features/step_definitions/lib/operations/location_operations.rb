require_relative '../../../support/cal_utils/operations'
require_relative '../screens/dashboard_screen'

#Location is an array of all locations for customer "C"
#The  selects the last element in the array of Locations
#Or in other words, the Location that needs to be added
#The i for the check is the index to check so you can select which element from the Location array to check for

module Android
  module LocationOperations
    class << self
      include Calabash::CalabashUtils::Operations

		  def add(location)
        touch_elem(LocationScreen.add_location)
        sleep 0.5
        performAction('go_back')
        set_text_field(LocationScreen.location_name, location.name)						        #NAME
        set_text_field(LocationScreen.address_1, location.address1)						        #ADDRESS1
        set_text_field(LocationScreen.address_2, location.address2)						        #ADDRESS2
        set_text_field(LocationScreen.city, location.city)								            #CITY
        touch_elem(LocationScreen.choose_state)									                          #STATE
        scroll_row_until_elem("* text:'#{location.state}' index:0", 5, 0)
        touch_elem(LocationScreen.select(location.state))
        set_text_field(LocationScreen.zip, location.zip_code)							            #ZIP
        set_text_field(LocationScreen.phone1, location.phone_number1)							    #CONTACT 1
        touch_elem(LocationScreen.choose_phone1_type)
        touch_elem(LocationScreen.select_phone1_type(location.phone_type1))
        performAction('scroll_down')
        set_text_field(LocationScreen.phone_1_contact, location.contact1)
        set_text_field(LocationScreen.phone2, location.phone_number2)							    #CONTACT 2
        touch_elem(LocationScreen.choose_phone2_type)
        touch_elem(LocationScreen.select_phone2_type(location.phone_type2))
        set_text_field(LocationScreen.phone_2_contact, location.contact2)
        set_text_field(LocationScreen.location_code, location.location_code)			    #LOCATION CODE
        set_text_field(LocationScreen.description, location.description)				      #DESCRIPTION
        touch_elem(LocationScreen.create)											                            #SUBMIT
        location.save_to_file
      end

      def check(location)
        touch_elem(LocationScreen.loc_exists(location))                                   #CHECK
        touch_elem(LocationScreen.edit)
        sleep 0.5
        performAction('go_back')
        elem_exists? LocationScreen.check(location.name)
        elem_exists? LocationScreen.check(location.address1)
        elem_exists? LocationScreen.check(location.address2)
        elem_exists? LocationScreen.check(location.city)
        elem_exists? LocationScreen.check(location.state)
        elem_exists? LocationScreen.check(location.zip_code)
        elem_exists? LocationScreen.check(location.phone_number1)
        elem_exists? LocationScreen.check(location.phone_type1)
        performAction('scroll_down')
        elem_exists? LocationScreen.check(location.contact1)
        elem_exists? LocationScreen.check(location.phone_number2)
        elem_exists? LocationScreen.check(location.phone_type2)
        elem_exists? LocationScreen.check(location.contact2)
        elem_exists? LocationScreen.check(location.location_code)
        elem_exists? LocationScreen.check(location.description)
        touch_elem(LocationScreen.back)
      end
	  end
  end
end


####################################################################################################################
#													                          IOS															                               #
####################################################################################################################

module IOS
  module LocationOperations
    class << self
      include Calabash::CalabashUtils::Operations
		
      def add(location)
        touch_elem(LocationScreen.add_location)

        set_text_field(LocationScreen.location_name, location.name)						        #NAME
        set_text_field(LocationScreen.address_1, location.address1)						        #ADDRESS1
        set_text_field(LocationScreen.address_2, location.address2)						        #ADDRESS2
        set_text_field(LocationScreen.city, location.city)								            #CITY
        scroll_row_until_elem("* text:'#{location.state}' index:0", 5, 0)             #STATE
        touch_elem(LocationScreen.select(location.state))
        touch_elem(LocationScreen.select(location.state))
        touch_elem(LocationScreen.done)
        set_text_field(LocationScreen.zip, location.zip_code)							            #ZIP

        keyboard_enter_text(location.phone_number1)											              #CONTACT 1
        touch_elem(LocationScreen.choose_phone1_type)
        touch_elem(LocationScreen.select_phone1_type(location.phone_type1.upcase))
        touch_elem(LocationScreen.done)
        set_text_field(LocationScreen.phone_1_contact, location.contact1)

        keyboard_enter_text(location.phone_number2)											              #CONTACT 2
        touch_elem(LocationScreen.choose_phone2_type)
        touch_elem(LocationScreen.select_phone2_type(location.phone_type2.upcase))
        touch_elem(LocationScreen.done)
        set_text_field(LocationScreen.phone_2_contact, location.contact2)

        set_text_field(LocationScreen.location_code, location.location_code)          #LOCATION CODE
        set_text_field(LocationScreen.description, location.description)		          #DESCRIPTION
        touch_elem(LocationScreen.submit)										                              #SUBMIT
        location.save_to_file
      end

      def check(location)
        touch_elem(LocationScreen.loc_exists(location))                                #CHECK
        elem_exists? LocationScreen.check(location.name)
        elem_exists? LocationScreen.check(location.address1)
        elem_exists? LocationScreen.check(location.address2)
        elem_exists? LocationScreen.check(location.city)
        elem_exists? LocationScreen.check(location.state)
        elem_exists? LocationScreen.check(location.zip_code)
        elem_exists? LocationScreen.check_phone(location.phone_number1)
        elem_exists? LocationScreen.check(location.phone_type1.upcase)
        elem_exists? LocationScreen.check(location.contact1)
        elem_exists? LocationScreen.check_phone(location.phone_number2)
        elem_exists? LocationScreen.check(location.phone_type2.upcase)
        elem_exists? LocationScreen.check(location.contact2)
        elem_exists? LocationScreen.check(location.location_code)
        uia_scroll_to :view, marked:"#{location.description}"
        touch_elem(LocationScreen.back)
      end
    end
  end
end