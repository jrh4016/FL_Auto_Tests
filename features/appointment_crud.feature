Feature: Adding an Appointment

Background:
  Given I login

Scenario: I can add a new appointment
  And I goto the "dashboard customers" screen
  Then I search for and open customer "C"
  Then I goto the "customer new appointment" screen
  Then I add a new appointment "A" for customer "C" at "Billing Address"

#Scenario: I can view new appointment
#  And I goto the "my schedule" screen
#  Then I open appointment "A"
#  Then I goto the "appointment notes" screen
#  Then I change the note for appointment "A"