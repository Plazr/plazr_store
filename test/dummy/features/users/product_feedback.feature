Feature: Rate a product afet a purchase

  In order to classify a purchase
  As a user
  I should be able give feedback

  Stakeholder: User
  Priority: Medium

  Scenario: Add feedback successfully
  	Given I have bought a product
    And I on the purchase history page
    When I click to rate the product
    And I fill in the rate form
    Then I should see success a message
    And I should see my rate on the product