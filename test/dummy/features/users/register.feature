Feature: Register with email and password

	I should be able to register with email and password.

	Stakeholder: User
	Priority: Essential

	Scenario: Register with email and password
		Given I am on the front page
		When I click to register
		And I fill in the register form
		And I click to register
		Then I should see a success message
