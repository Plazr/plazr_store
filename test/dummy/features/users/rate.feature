Feature: Rate
  As a user
  I want to rate a product

  Stakeholder: User
  Priority: Medium

  Scenario: Classificate a product
	Given I should be a authenticated user
	And I should bought a product
	When I rate a product
	Then I should see my rating