Feature: Notification of replacement stock

  In order to buy a product that is exhausted
  As a user of the store
  I want to be able to request the stock replacement
  
  Stakeholder: User
  Priority: High

  Scenario: Request notification
    Given I am on product page
    And I am registered user
    And the product is exhausted
    When I press replacment stock button
    Then I should see success message

  Scenario: Replacement stock
    Given I am on my home page
    And I request notification for replacement stock
    When the owner increase the stock of the product
    Then I should see message from owner