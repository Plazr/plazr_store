Feature: Search Products
  In order to search products according to some parameters
  As user
  I want to see all the products that sastify there parameters
  
  Stakeholder: User
  Priority: Essential

  Scenario: Search Products successfully
    Given I should be in a search page
    And I want to search products according to some parameters
	  When I select the parameters 
    And I press the search button
	  Then I should see all the products that satisfy these parameters