Feature: Adding a location

Background:
  Given I login
  And I goto the "dashboard customers" screen

Scenario: I can add a new location to a customer
  Then I search for and open customer "C"
  Then I goto the "customer locations" screen
  Then I add a new location "L" for customer "C"
  Then I check location "L"
