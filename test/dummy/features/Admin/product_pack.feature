Feature: Create Pack
  In order to create a product pack
  As a owner
  I want create a product pack

  Stakeholder: Owner
  Priority: Very low

  Scenario: Create a group of products
	Given I should be a owner of the store
	And I should be a authenticated
	And I am a manage product page
	When I press the group itens button
	And I insert a name of group
	And I press submit button
	Then I sould see a sucess message