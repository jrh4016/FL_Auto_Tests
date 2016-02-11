Feature: Adding Equipment and a Service Agreement to an already created Appointment

Background:
  Given I login
  And I goto the "dashboard my schedule" screen
  Then I open appointment "A" for customer "C"

Scenario: I can add equipment to the appointment
  Then I goto the "appointment add equipment" screen
  Then I add equipment "E" to appointment "A"

Scenario: I can add a service agreement to the appointment
  Then I goto the "appointment add service agreement" screen
  Then I add service agreement "S" to appointment "A"
  Then I goto the "appointment invoice" screen
  Then I check that invoice "I" updated after applying service plan "S" to appointment "A"
 		
 		
 		