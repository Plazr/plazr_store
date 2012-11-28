Feature: Own domain
  In order to use my own domain
  As a registered owner of a store
  I want to access my own store through my domain

  Stakeholder: Owner
  Priority: Essential    

  Scenario: Use own domain
    Given I am the registered owner of a store
    And there are other owners of stores
    And I am create a new store
    And I want to use my own domain 
	  And I select use my own domain
	  And I write de domain 
    When I press submission button
    And write my own domain in browser
    Then I should redirect to my store in Plazr