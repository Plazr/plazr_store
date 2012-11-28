Feature: Shopping Cart

  As user
  I want to save shopping carts

  Stakeholder: User
  Priority: Very Low

  Scenario: Save Shopping Cart
  	Given I am on checkout page
  	And I have products to buy
  	When I press save cart button
  	Then I should see success message

  Scenario: See Shopping Cart saved
    Given I am on my home page
    And I have shopping carts saved
  	When I press one cart
  	Then I should see products of this cart