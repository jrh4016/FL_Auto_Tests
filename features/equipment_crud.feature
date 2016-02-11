Feature: Adding equipment to a customer

Background:
  Given I login
  And I goto the "dashboard customers" screen

Scenario: I can add equipment to a customer
  Then I search for and open customer "C"
  Then I goto the "customer equipment" screen
  Then I add new equipment "E" for customer "C"
  Then I check equipment "E"
