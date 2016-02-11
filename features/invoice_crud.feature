Feature: Adding an Invoice

Background:
  Given I login
  And I goto the "dashboard my schedule" screen
  Then I open appointment "A" for customer "C"

Scenario: I can add an Invoice to an Appointment
  Then I goto the "appointment invoice" screen
  Then I create invoice "I" for appointment "A"

