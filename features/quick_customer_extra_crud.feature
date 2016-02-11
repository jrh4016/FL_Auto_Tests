Feature: I add an extra Location, Equipment, and Service Agreement

Background:
  Given I login
  And I goto the "dashboard customers" screen
  Then I search for and open customer "C"

Scenario: I add an extra Location, Equipment, and Service Agreement
  Then I goto the "customer locations" screen
  Then I add a new location "L" for customer "C"
  Then I go back to the previous screen
  Then I goto the "customer equipment" screen
  Then I add new equipment "E" for customer "C"
  Then I go back to the previous screen
  Then I goto the "customer service agreements" screen
  Then I add new service agreement "S" for customer "C"
  Then I go back to the previous screen
  Then I add a phone number "PN" for customer "C"
  Then I add an email address "EA" for customer "C"
  Then I add a note "NT" for customer "C"



 		
 		

