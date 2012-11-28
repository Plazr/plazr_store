Feature: Checkout
  In order to complete purchases 
  As a user of web store
  I want to checkout on single page

  Stakeholder: User 
  Priority: High

  Scenario: Checkout successfully
    Given I am on checkout page
  	And I have products in my shopping cart
  	When I select the form of payment
  	And I click on checkout button
  	Then I should see a success message

  Scenario: Impossible	Checkout
    Given I am on checkout page
  	And I have not products in my shopping cart 
  	And I should not see checkout button