Feature: Rate
	In order to rate a product
	I want to rate a product

	Stakeholder: User
	Priority: Medium

	Scenario: Classificate a product
		Given I should be a authenticated client
		And I should bought a product
		When I rate a product
		Then I should see my rating