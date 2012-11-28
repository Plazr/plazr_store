Feature: Owners must be able to create pages

  In order to promote my business
  As a owner of store
  I want to be able create new pages

  Stakeholder: Owner
  Priority: High

  Scenario: Create new page
    Given I am on backoffice page
    When I select new page button
    And I fill the form with name and description
    And I press submission button
    Then I should see success message 
    And I should be redirect to page created 
    And I should see in my store link to the new page created

  Scenario: Edit page created
  	Given I am on backoffice
  	And I have pages created
  	When I select one page
  	And I press edit button
  	And I change the form
  	And I press submission button
  	Then I should see sucess message
  	And I should be redirect to page edited 