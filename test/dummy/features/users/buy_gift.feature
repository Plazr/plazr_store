Feature: Buy gift to offer

  In order to give a present
  As a user
  I want to be able buy a product and sends it to a destination
  
  Stakeholder: User
  Priority: High

  Scenario: Buy gift
    Given I am on product page
    When I press buy product button
    And I press send gift
    And I fill form with description and destination address
    And I press submition button
    Then I should see success message