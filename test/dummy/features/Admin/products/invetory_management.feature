Feature: Inventory Management

  In order manage my products
  As as store owner
  I should be able to edit my stock quantity and availability

  Stakeholder: Owner
  Priority: Medium

  Scenario: Increase stock
  	Given I am on the admin page
  	And I have a product
  	When I click to edit the product
    And I increase the stock
    And I click submit
  	Then I should see a success message
  	And the product should be updated

  Scenario: Decrease stock
    Given I am on the admin page
    And I have a product
    When I click to edit the product
    And I decrease the stock
    And I click submit
    Then I should see a success message
    And the product should be updated

  Scenario: Available to order
  	Given I am on backoffice
  	And I have a unavailable product
    When I click to edit the product
    And I make it availabe
    And I click submit
  	Then I should see a success message
  	And the product should be available