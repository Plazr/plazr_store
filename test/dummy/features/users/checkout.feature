Feature: Checkout

  In order to complete purchases
  As a user
  I want to checkout on a single page

  Stakeholder: User
  Priority: High

  Scenario: Checkout successfully
  	Given I have products in my shopping cart
    When I click to checkout
  	And I fill in the checkout form
  	And I click to submit
  	Then I should see a success message

  Scenario: Impossible	Checkout
  	Given I have no products in my shopping cart
    When I click to checkout
    Then I should see a no products message