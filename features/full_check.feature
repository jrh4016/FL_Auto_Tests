Feature: I check all data for the customer

Background:
  Given I login

Scenario: All the checks
  Then I goto the "dashboard invoices" screen
  Then I open invoice "I" for customer "C" from the list
  Then I check invoice "I"
  Then I go back to the previous screen
  Then I go back to the previous screen
  Then I goto the "dashboard customers" screen
  Then I search for and open customer "C"
  Then I goto the "customer locations" screen
  Then I check all locations for customer "C"
  Then I go back to the previous screen
  Then I goto the "customer equipment" screen
  Then I check all equipment for customer "C"
  Then I go back to the previous screen
  Then I goto the "customer service agreements" screen
  Then I check all service agreements for customer "C"
  Then I go back to the previous screen
  Then I goto the "customer history" screen
  Then check that appointment "A" closed for customer "C"
  Then I go back to the previous screen
  Then I go back to the previous screen
  Then I check all phone numbers "PN", email addresses "EA", and notes "NT" for customer "C"