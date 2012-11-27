Feature: Carts

  As user
  I want to save carts

  Stakeholder: User
  Priority: Very Low

  Scenario: Save Cart
  	Given I am on cart page
  	And I have products to buy
  	When I press save cart button
  	Then I should see success message