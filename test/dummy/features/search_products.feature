Feature: Search Products
  In order to search according to some parameters
  As an user registered
  I want to see all the products that sastify there parameters
  
  Stakeholder: User
  Priority: Essential 

  Background: I should be registered and authenticated
    Given I am registered
    And there are other users registered
    And I am on the front page
    And I want to search products according to some parameters

  Scenario: Search Products successfully
	  When I select the parameters 
    And I press the search button
	  Then I should see all the products that satisfy these parameters

  Scenario: Search Products unsuccessfully
    When I select the parameters 
    And I press the search button
    And there is no product that satisfy these parameters
    Then show an empty message list