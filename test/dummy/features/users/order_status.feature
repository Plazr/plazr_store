Feature: Order-Status
  In order to see a product status
  As a user
  I want to follow my product

  Stakeholder: User
  Priority: Medium

  Scenario: See order-status
	Given I should be a authenticated user
	And I sould bought a product
	And I am in my products page
	When I select a product
	Then I should see the state of purchase