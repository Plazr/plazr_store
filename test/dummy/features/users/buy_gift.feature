Feature: Buy gift to offer

  In order to buy products as a gift
  As a user
  I should be able to see the gift option

  Stakeholder: User
  Priority: High

  Scenario: Buy as a gift
    Given I am on a product page
    When I click to buy
    Then I should see a send as a gift option