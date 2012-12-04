 Feature: Organization of the stores by categories

  In order see stores organized by categories
  As a user
  I want to be able see all stores assocciated with a category 	
  
  Stakeholder: User
  Priority: High 

  Scenario: See stores by categories
  	Given I am user
  	And I am on central page of Plazr
  	When I select stores by categories
  	And select one category
  	Then I should see all the stores that are associated with this category