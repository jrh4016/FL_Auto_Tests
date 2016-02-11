Feature: Adds a phone number, email address, and a note to a customer

Background:
  Given I login
  And I goto the "dashboard customers" screen
  Then I search for and open customer "C"

Scenario: I can add a phone number, email and note to a customer
  Then I add a phone number "PN" for customer "C"
  Then I add an email address "EA" for customer "C"
  Then I add a note "NT" for customer "C"
  Then I go back to the previous screen
  Then I search for and open customer "C"
  Then I check all phone numbers "PN", email addresses "EA", and notes "NT" for customer "C"
