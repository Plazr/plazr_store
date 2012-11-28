Feature: Own domain
  In order to use my own domain
  As a registered owner of a store
  I want to access my own store through my domain

  Stakeholder: Owner
  Priority: Essential    

  Scenario: Use own domain
    Given I am create a new store
	  When I select use my own domain
	  And I write the domain 
    And I press submission button
    Then I should see success message
    And is downloaded the page to import of my domain

  Scenario: See my store
    Given I am on browser
    And I am created a Plazr store
    And I configured my own domain
    When I write the my domain on browser
    Then I should be redirect to my Plazr store