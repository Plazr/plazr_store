Feature: Create Pack

	In order to create a product pack
	As a store owner
	I should be able to select multiple products


  	Stakeholder: Owner
  	Priority: Very low

	Scenario: Create a group of products
    	Given I am registered
    	And I am a store owner
		And I am on the products edit page
		When I select multiple products
		And I click to create a product pack
		And I fill in the product pack form
		And I click submit
		Then I sould see a sucess message
		And I should see the product pack in my products page
