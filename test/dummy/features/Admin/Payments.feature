Feature: Payments
	In order to manage the payments methods
	I want to select the payment methods available

	Stakeholder: Owner
	Priority: High

	Scenario: Modify the payment method
		Given I should be owner of the store and authenticated
		And I am logged as store owner
		And I am in the store
		And I am on page setup payment methods
		When I select the payments methods that i want
		And I Press the submit button
		Then I should see the sucess message

	Scenario: Select one or more payments methods
		Given I sould be a new owner of the new store
		And I am in the criation store page
		When I select one or more the methods i want
		And I press submit button
		Then I should see the sucess message

	Scenario: Do not select any payment method
		Given I sould be a new owner of the new store
		And I am in the criation store page
		When I not select any payment method
		And I press submit button
		Then I should see the error message