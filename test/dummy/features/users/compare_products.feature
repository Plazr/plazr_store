Feature: Compare products
  In order to compare diferent products
  As a user
  I want comparate products for that caracteristics

  Stakeholder: User
  Priority: Low
  
  Scenario: Comparate products
	Given I am in a products page
	When I select two or more products
	And I press a compare button
	Then I sould see the products side by side