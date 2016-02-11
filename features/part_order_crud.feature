Feature: Adding a part order to an appointment

Background:
    Given I login
    And I goto the "dashboard my schedule" screen

Scenario: I can order a new part for an appointment
    Then I open appointment "A" for customer "C"
    Then I goto the "appointment part orders" screen
    Then I add a new part
    Then I add a labor rate
    Then I add an additional charge