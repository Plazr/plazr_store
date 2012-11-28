Feature: Reports

  In order to control the activity of store
  As owner
  I want to be able to see reports and graphics

  Stakeholder: Owner
  Priority: Essential

  Scenario: See reports succeffully
  	Given I am on backoffice
  	And I have sell products
  	When I press reports button
  	Then I should see the reports and graphics from my store

  Scenario: See reports unsucceffully
    Given I am on backoffice
  	And I have not still sell products
  	When I press reports button
  	Then I should see a unsuccess message