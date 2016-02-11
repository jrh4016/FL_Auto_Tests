Feature: Adding an Estimate

Background:
    Given I login
    And I goto the "dashboard my schedule" screen
    Then I open appointment "A"
    Then I goto the "appointment estimate" screen

Scenario: I can add an Estimate to an Appointment
    Then I create an estimate

Scenario: I can add a custom taxable item
    Then I add a new custom line item and discount
