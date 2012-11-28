Feature: Inventory Management

  In order to see the status of a product
  As owner
  I want to manage the inventory

  Stakeholder: User
  Priority: Medium

  Scenario: Increase stock
  	Given I am on backoffice
  	And one product is unavailable
  	When I increase the stock
  	Then I should see success message
  	And I should see product available

  Scenario: Decrease stock
    Given I am on backoffice
  	And one product is available with 5 items
  	When I increase stock button 5 times
  	Then I should see success message
  	And I should see this product unvailable

  Scenario: Available to order
  	Given I am on backoffice
  	And one products is unavailable
  	When I press available to order
  	Then I should see success message
  	And I should see this product available to order