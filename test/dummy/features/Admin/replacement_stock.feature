Feature: Notification of replacement stock

  In order to buy a product that is exhausted
  As a user of the store
  I want to be able to request the stock replacement
  
  Stakeholder: Owner
  Priority: High

  Scenario: Request notification
    Given I am on product page
    And I am registered user
    And the product is exhausted
    When I press replacment stock button
    Then I should see success message

   Scenario: Receive notification of stock replacement
    Given I am owner
    And the product is exhausted
    And the user request notification
    Then I should see message of request

   Scenario: Replacement stock
    Given I am owner
    And the product is exhausted
    And the user request notification 
    And I increase the stock of the product
    Then should be sent a message to user