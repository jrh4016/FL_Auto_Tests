require_relative '../../../support/cal_utils/operations'
require_relative '../screens/dashboard_screen'

#Equipment is an array of all locations for customer "C"
#The  selects the last element in the array of Equipments
#Or in other words, the Equipment that needs to be added
#The i for the check is the index to check so you can select which element from the Equipment array to check for

module Android
  module EquipmentOperations
    class << self
      include Calabash::CalabashUtils::Operations

      def add(equipment)
        touch_elem(EquipmentScreen.new_equipment)

        set_text_field(EquipmentScreen.equipment_name, equipment.name) 						              #NAME
        set_text_field(EquipmentScreen.serial_number, equipment.serial_num) 	  	              #SERIAL NUMBER
        set_text_field(EquipmentScreen.model_number, equipment.model_num) 					            #MODEL NUMBER
        set_text_field(EquipmentScreen.custom_code, equipment.custom_code) 					            #CUSTOM CODE

        touch_elem(EquipmentScreen.choose_manufacturer)								                          #MANUFACTURER
        touch_elem(EquipmentScreen.select(equipment.manufacturer))

        set_text_field(EquipmentScreen.filter, 'Blender') 									                    #FILTER

        touch_elem(EquipmentScreen.choose_location)							                                #LOCATION
        touch_elem(EquipmentScreen.select(equipment.location))

        touch_elem(EquipmentScreen.installed_date)								                              #INSTALLED DATE
        touch_elem(EquipmentScreen.save_date)

        touch_elem(EquipmentScreen.part_warranty_date)							                            #PART WARRANTY DATE
        touch_elem(EquipmentScreen.increment_year)
        touch_elem(EquipmentScreen.increment_year)
        touch_elem(EquipmentScreen.save_date)

        touch_elem(EquipmentScreen.labor_warranty_date)						                              #LABOR WARRANTY DATE
        touch_elem(EquipmentScreen.increment_year)
        touch_elem(EquipmentScreen.save_date)

        set_text_field(EquipmentScreen.warranty_holder, equipment.manufacturer) 	              #WARRANTY CONTRACT HOLDER
        set_text_field(EquipmentScreen.warranty_number, equipment.warranty_num)  	              #WARRANTY CONTRACT NUMBER
        performAction('scroll_down')

        touch_elem(EquipmentScreen.next_service_date)							                              #NEXT SERVICE DATE
        (1..3).each { touch_elem(EquipmentScreen.increment_month) }
        touch_elem(EquipmentScreen.save_date)
        touch_elem(EquipmentScreen.save_equipment) 									                            #SAVE EQUIPMENT
        touch_elem(EquipmentScreen.open_equipment(equipment))
        sleep 1
        performAction('scroll_down')
        touch_elem(EquipmentScreen.plus_button)
        set_text_field(EquipmentScreen.condition_description, equipment.description)
        touch_elem(EquipmentScreen.condition_spinner)
        touch_elem(EquipmentScreen.select(equipment.condition))
        touch_elem(EquipmentScreen.save)
        equipment.save_to_file
        touch_elem(EquipmentScreen.back)
      end

      def check(equipment)
        touch_elem(EquipmentScreen.open_equipment(equipment))                                 #CHECK
        elem_exists? EquipmentScreen.check(equipment.name)
        elem_exists? EquipmentScreen.check(equipment.manufacturer)
        elem_exists? EquipmentScreen.check(equipment.location)                                #LOCATION IS STILL MISSING THE SPACE BETWEEN ADDRESS 1 AND ADDRESS 2
        elem_exists? EquipmentScreen.check(equipment.serial_num)
        elem_exists? EquipmentScreen.check(equipment.model_num)
        elem_exists? EquipmentScreen.check("Custom code: #{equipment.custom_code}")
        elem_exists? EquipmentScreen.check("Installation Date: #{equipment.installed_date.strftime('%-m/%-d/%Y')}")
        elem_exists? EquipmentScreen.check("Warranty Expiration Date: #{equipment.part_warranty_date.strftime('%-m/%-d/%Y')}")
        elem_exists? EquipmentScreen.check("Warranty contract holder: #{equipment.warranty_holder}")
        elem_exists? EquipmentScreen.check("Warranty contract number: #{equipment.warranty_num}")
        performAction('scroll_down')
        elem_exists? EquipmentScreen.check("Labor Warranty Expiration Date: #{equipment.labor_warranty_date.strftime('%-m/%-d/%Y')}")
        elem_exists? EquipmentScreen.check("Next Service Call Date: #{equipment.next_service_date.strftime('%-m/%-d/%Y')}")
        elem_exists? EquipmentScreen.check("Filter: #{equipment.filter}")
        elem_exists? EquipmentScreen.check(equipment.description)
        elem_exists? EquipmentScreen.check("Condition: #{equipment.condition}")
        touch_elem(EquipmentScreen.back)
      end
	 end
  end
end


####################################################################################################################
#													                            IOS															                             #
####################################################################################################################

module IOS
  module EquipmentOperations
    class << self
      include Calabash::CalabashUtils::Operations

      def add(equipment)
        touch_elem(EquipmentScreen.edit)
        touch_elem(EquipmentScreen.add_equipment)

        touch_elem(EquipmentScreen.choose_location)									                            #LOCATION
        touch_elem(EquipmentScreen.select(equipment.location))
        touch_elem(EquipmentScreen.done)

        touch_elem(EquipmentScreen.choose_manufacturer)							                            #MANUFACTURER
        touch_elem(EquipmentScreen.select(equipment.manufacturer))
        touch_elem(EquipmentScreen.done)

        set_text_field(EquipmentScreen.equipment_name, equipment.name) 						              #NAME
        set_text_field(EquipmentScreen.serial_number, equipment.serial_num) 	  	              #SERIAL NUMBER
        set_text_field(EquipmentScreen.model_number, equipment.model_num) 	   		              #MODEL NUMBER
        set_text_field(EquipmentScreen.filter, equipment.filter) 					 				              #FILTER
        set_text_field(EquipmentScreen.custom_code, equipment.custom_code) 	 			              #CUSTOM CODE


        touch_elem(EquipmentScreen.installed_date)								                              #INSTALLED DATE
        query('datePicker', setDate:equipment.installed_date.next_day)
        touch_elem(EquipmentScreen.done)

        touch_elem(EquipmentScreen.part_warranty_date)							                            #WARRANTY DATE
        query('datePicker', setDate:equipment.part_warranty_date.next_day)
        touch_elem(EquipmentScreen.done)

        set_text_field(EquipmentScreen.warranty_holder, equipment.warranty_holder) 		          #WARRANTY HOLDER
        set_text_field(EquipmentScreen.warranty_number, equipment.warranty_num)

        touch_elem(EquipmentScreen.next_service_date)								                            #NEXT SERVICE DATE
        query('datePicker', setDate:equipment.next_service_date.next_day)
        touch_elem(EquipmentScreen.done)

        touch_elem(EquipmentScreen.labor_warranty_date)							                            #LABOR WARRANTY DATE
        query('datePicker', setDate:equipment.labor_warranty_date.next_day)
        touch_elem(EquipmentScreen.done)

        touch_elem(EquipmentScreen.submit)			                                                #SUBMIT
        touch_elem(EquipmentScreen.done)
        touch_elem(EquipmentScreen.open_equipment(equipment))
        uia_scroll_to :view, marked:'Service Records'
        touch_elem(EquipmentScreen.plus_button)                                                 #ADD SERVICE RECORD
        touch_elem(EquipmentScreen.select(equipment.condition.upcase))
        touch_elem(EquipmentScreen.select(equipment.condition.upcase))
        touch_elem(EquipmentScreen.done)
        set_text_field(EquipmentScreen.condition_description, equipment.description)
        touch_elem(EquipmentScreen.save)
        equipment.save_to_file
        touch_elem(EquipmentScreen.back)
      end

      def check(equipment)
        touch_elem(EquipmentScreen.open_equipment(equipment))                                    #CHECK
        elem_exists? EquipmentScreen.check(equipment.name)
        elem_exists? EquipmentScreen.check(equipment.manufacturer)
        elem_exists? EquipmentScreen.check(equipment.location)
        elem_exists? EquipmentScreen.check(equipment.serial_num)
        elem_exists? EquipmentScreen.check(equipment.model_num)
        elem_exists? EquipmentScreen.check(equipment.filter)
        elem_exists? EquipmentScreen.check(equipment.custom_code)
        elem_exists? EquipmentScreen.check_date(equipment.installed_date)
        elem_exists? EquipmentScreen.check_date(equipment.part_warranty_date)
        scroll 'scrollView index:0', :down
        elem_exists? EquipmentScreen.check(equipment.warranty_holder)
        elem_exists? EquipmentScreen.check(equipment.warranty_num)
        elem_exists? EquipmentScreen.check_date(equipment.next_service_date)
        uia_scroll_to :view, marked:'Service Records'
        elem_exists? EquipmentScreen.check_date(equipment.labor_warranty_date)
        elem_exists? EquipmentScreen.check(equipment.description)
        #elem_exists? EquipmentScreen.check("Condition: #{equipment.condition}")
        touch_elem(EquipmentScreen.back)
      end
    end
  end
end