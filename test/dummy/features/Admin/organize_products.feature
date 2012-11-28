Feature: Organize products
  In order to organize products
  As a registered owner of a store
  I want to associate multiple tags to the products

  Stakeholder: Owner
  Priority: Essential 

  Background: I should be registered and authenticated
    Given I am the registered owner of a store
    And there are other owners of stores
    And I am on the back office

  Scenario: Categorize products
	When I select the product 
	And I press the edit button
    And I write the category to associate
    And I press submit button
    Then I should see the edited product im my store
    And the product should be associate with these category

  Scenario: Automatically categorize products
    #completar

  Scenario: See products by category
	When I select the category
    Then I should see the all the products associated whith these category