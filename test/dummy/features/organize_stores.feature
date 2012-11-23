Feature: Organization of the stores by categories

  In order to organize the stores
  As a owner of the store
  I want to be able to define my store by categories 	
  
  Stakeholder: Owner
  Priority: High

  Scenario: Create a new store
    Given I am on create store page
    And I am setting the type of store
    When I select the categories
    And I press submition button 
    Then I should see success message
    And the store is associated with these categories

  Scenario: Edit store
    Given I am on edit store page
    And I am editing the type of store
    When I select the new categories
    And I press submition button 
    Then I should see success message
    And the store is associated with these new categories

  Scenario: See stores by categories
  	Given I am user
  	And I am on central page of Plazr
  	When I select stores by categories
  	And select one category
  	Then I should see all the stores that are associated with this category