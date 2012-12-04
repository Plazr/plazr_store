Feature: Owners must be able to create pages

  In order display some information
  As a store owner
  I should be able to create pages

  Stakeholder: Owner
  Priority: High

  Scenario: Create a new page
    Given I am registered
    And I am a store owner
    Given I am on the admin page
    When I click to create a new page
    And I fill in the new page form
    And I click submit
    Then I should see success message
    And I should be in my new page

  Scenario: Edit page created
    Given I am registered
    And I am a store owner
    Given I am on the admin page
  	And I have a page
  	When I click to edit the page
  	And I change the page information
    And I click submit
    Then I should see success message
    And I should be in my new page

