Feature: Compare products

  In order decide between two products
  As a user
  I should be able to comparate products in the same page

  Stakeholder: User
  Priority: Low

  Scenario: Comparate products
	Given I am on a store
	When I select two products
	And I click to compare
	Then I should be in a comparation page
  And I should see both products