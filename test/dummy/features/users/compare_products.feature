Feature: Compare products
	In order to compare diferent products
	I want comparate products for that caracteristics

	Stakeholder: client of an online store
	Priority: Low


	Scenario: Comparate products
		Given I am in a products page
		When I select two or more products
		And I press a compare button
		Then I sould see the products side by side