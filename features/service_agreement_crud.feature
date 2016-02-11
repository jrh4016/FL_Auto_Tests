Feature: Adding a Service Agreement

Background:
  Given I login
  And I goto the "dashboard customers" screen

Scenario: I can add a new service agreement
  Then I search for and open customer "C"
  Then I goto the "customer service agreements" screen
  Then I add new service agreement "S" for customer "C"
  Then I check service agreement "S"
