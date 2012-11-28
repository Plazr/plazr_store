Feature: buy with other users
	In order to buy a product with other users
	I want to buy a product with other users

	Stakeholder: client of an online store
	Priority: very low


	Scenario: buy a product with other users
		Given I should be a authenticate client
		And I am in a checkout page
		When I select the other users
		And I press button to pay with others
		Then Other users should be notificated