Feature: Organization of the stores by categories

  In order to organize the stores
  As a owner
  I want to be able to define store by categories 	
  
  Stakeholder: Owner
  Priority: High

  Scenario: Assign a category to a store
    Given I am on create store page
    And I am setting the type of store
    When I select the categories
    And I press submit
    Then I should see a success message
    And the store is associated with these categories

  Scenario: Edit store
    Given I am on edit store page
    And I am editing the type of store
    When I select the new categories
    And I press submit
    Then I should see a success message
    And the store is associated with these new categories