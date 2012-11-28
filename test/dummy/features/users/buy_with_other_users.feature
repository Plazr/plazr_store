Feature: Buy with other users
  As a user
  I want to buy a product with other users

  Stakeholder: User
  Priority: Very low

  Scenario: Buy a product with other users
    Given I should be a authenticate user
	And I am in a checkout page
	When I select the other users
	And I press button to pay with others
	Then Other users should be notificated