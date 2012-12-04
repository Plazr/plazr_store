Feature: Payments

	In order to manage the payment methods
	As a store owner
	I want to select from payment methods available

	Stakeholder: Owner
	Priority: High

	Scenario: Modify the payment method
    	Given I am registered
    	And I am a store owner
		And I am on the store edit page
		When I click to edit the payment methods
		And I modify the selection
		And I press the submit button
		Then I should see a success message

	Scenario: Select one or more payments methods
    	Given I am registered
    	And I am a store owner
		And I am on the store edit page
		When I select one payment method
		And I press submit button
		Then I should see the sucess message

	Scenario: Do not select any payment method
    	Given I am registered
    	And I am a store owner
		And I am on the store edit page
		When I not select any payment method
		And I press submit button
		Then I should see the error message
		And should be in the payment method selection page