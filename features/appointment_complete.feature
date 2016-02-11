Feature: Changing the Status of an Appointment

Background:
  Given I login

Scenario: I can finish an appointment
  And I goto the "dashboard my schedule" screen
  Then I open appointment "A" for customer "C"
  Then I update appointment "A"
  And I complete invoice "I" for appointment "A" for customer "C"

#Scenario: I check that the appointment finished
#  Then I goto the "dashboard invoices" screen
#  Then I open invoice "I" for customer "C" from the list
#  Then I check invoice "I"
#  Then I go back to the previous screen
#  Then I go back to the previous screen
#  Then I goto the "dashboard customers" screen
#  Then I search for and open customer "C"
#  Then I goto the "customer history" screen
#  And check that appointment "A" closed for customer "C"
 		
 		
 		