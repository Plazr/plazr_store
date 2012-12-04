Feature: Own domain

  In order to use my own domain
  As a store owner
  I should be able to specify my domain

  Stakeholder: Owner
  Priority: Essential

  Scenario: Use own domain
    Given I am registered
    And I am a store owner
    And I am on the store edit page
	  When I select to change my domain
	  And I fill in the domain form
    And I click submit
    Then I should see success message