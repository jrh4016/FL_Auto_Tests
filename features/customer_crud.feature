Feature: Adding a customer

	Background:
  		Given I login
 		And I goto the "dashboard customers" screen
 		 
	Scenario: I can add a new customer
		Then I add a new customer "C"
		Then I search for and open customer "C"