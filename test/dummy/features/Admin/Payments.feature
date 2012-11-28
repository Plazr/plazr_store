Feature: Payments
  In order to manage the payments methods
  As owner
  I want to select the payment methods available

  Stakeholder: Owner
  Priority: High

  Scenario: Modify the payment method
    Given I should be owner of the store and authenticated
	And I am on page setup payment methods
	When I select the payments methods that I want
	And I press submit
	Then I should see the a sucess message

  Scenario: Select one or more payments methods
	Given I sould be a owner
	And I am in the creation store page
	When I select one or more the methods I want
	And I press submit
	Then I should see a sucess message

  Scenario: Do not select any payment method
    Given I should be a owner
	And I am in the creation store page
	When I not select any payment method
	And I press submit
	Then I should see a error message