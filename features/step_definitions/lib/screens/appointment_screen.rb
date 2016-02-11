module Android
	module AppointmentScreen
		
		def self.select(sel)
			{text:"#{sel}", index:0, timeout:20}
		end

		def self.save_equipment
			{id:'btn_save_equipment', timeout:10}
		end

		def self.save_agreement
			{id:'dialog_list_button_save', timeout:10}
		end

		def self.status
			{id:'activity_appointment_textview_appointment_status', timeout:20}
		end

		def self.status_check(check)
			{id:'activity_appointment_textview_appointment_status', text:"#{check}", timeout:10}
    end

    def self.question1
      {id:'question_name', index:0, timeout:10}
    end

    def self.question2
      {id:'question_name', index:1, timeout:10}
    end

    def self.yes
      {id:'item_appt_question_true', index:0, timeout:10}
    end

    def self.no
      {id:'item_appt_question_false', index:0, timeout:10}
    end

    def self.confirm
      {id:'dialog_appt_question_button_confirm', index:0, timeout:10}
    end

    def self.save_questions
      {id:'btn_save_questions', index:0, timeout:10}
    end

    def self.cancel
      {id:'dialog_list_button_cancel', index:0, timeout:10}
    end


		
		#DASHBOARD
		
		def self.estimate
			{id:'activity_appointment_button_view_estimate', timeout:10}
		end
		
		def self.invoice
			{id:'activity_appointment_button_view_invoice', timeout:10}
		end
		
		def self.part_orders
			{id:'activity_appointment_button_part_order', timeout:10}
		end
				
		def self.add_service_agreement
			{id:'activity_appointment_button_add_agreement', timeout:10}
		end
		
		def self.add_equipment
			{id:'activity_appointment_button_add_equipment', timeout:10}
		end
				
		def self.add_notes
			{id:'activity_appointment_button_add_notes', timeout:10}
		end
		
		def self.checklist
			{id:'activity_appointment_button_checklist', timeout:10}
		end
		
		def self.view_comments
			{id:'activity_appointment_button_view_comments', timeout:10}
		end
		
		def self.photo_gallery
			{id:'activity_appointment_button_view_gallery', timeout:10}
		end
				
		def self.truck
			{id:'activity_appointment_button_on_truck_items', timeout:10}
		end

		def self.capture_photo
			{id:'activity_appointment_button_capture_photo', timeout:10}
		end
		
		def self.upload_file
			{id:'activity_appointment_button_upload_file', timeout:10}
		end
		
		def self.forms
			{id:'activity_appointment_button_pdf', timeout:10}
		end
		
		def self.back
			{id:'header_button_back', timeout:10}
		end
	end
end


####################################################################################################################
#													                          IOS															                               #
####################################################################################################################

module IOS
	module AppointmentScreen
		def self.screen
			{type:'view', marked:'Customers', timeout:10}
    end

    def self.back
      {type:'label', marked:'Back',  timeout:10}
    end
				
		def self.next
			{type:'button', marked:'Next',  timeout:10}
		end
		
		def self.submit
			{type:'button', marked:'Submit',  timeout:10}
    end

    def self.done
      {type:'button', marked:'Done',  timeout:10}
    end
		
		def self.check(check)
			{text:"#{check}", timeout:10}
		end
		
		def self.not_started
			{type:'label', marked:'Not Started', timeout:10}
		end
		
		def self.en_route
			{type:'label', marked:'En Route', timeout:10}
		end
		
		def self.begin_work
			{type:'label', marked:'Begin Work', timeout:10}
		end
		
		def self.continue_work
			{type:'label', marked:'Continue Work', timeout:10}
		end
		
		def self.working
			{type:'label', marked:'Working', timeout:10}
		end
		
		def self.pause
			{type:'label', marked:'Pause', timeout:10}
		end
		
		def self.paused
			{type:'label', marked:'Paused', timeout:10}
		end
		
		def self.parts_run
			{type:'label', marked:'Parts Run', timeout:10}
		end
		
		def self.work_finished
			{type:'label', marked:'Work Finished', timeout:10}
		end
		
		def self.select(get)
			{marked:"#{get}", timeout:10}
    end

    def self.cancel

    end
		
		
		
		
		# DASHBOARD
		def self.invoice
			{type:'button', marked:'appt invoice', timeout:10}
		end
		
		def self.photo_gallery
			{type:'button', marked:'appt photo gallery', timeout:10}
		end
		
		def self.capture_photo
			{type:'button', marked:'appt capture photo', timeout:10}
		end
		
		def self.part_orders
			{type:'button', marked:'appt part orders', timeout:10}
		end
		
		def self.estimate
			{type:'button', marked:'appt work estimate', timeout:10}
		end
		
		def self.on_truck
			{type:'button', marked:'appt on truck', timeout:10}
		end
		
		def self.appointment_notes
			{type:'button', marked:'appt add notes', timeout:10}
		end
		
		def self.add_equipment
			{type:'button', marked:'appt add equipment', timeout:10}
		end
		
		def self.add_service_agreement
			{type:'button', marked:'appt agreements', timeout:10}
		end
	end	
end