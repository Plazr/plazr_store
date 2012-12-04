Feature: Reports

  In order to manage my store
  As a store owner
  I want to be able to see reports and graphics

  Stakeholder: Owner
  Priority: Essential

  Scenario: Products have been sold
  	Given I have sold products
  	When I go to my stores statistics page
  	Then I should see reports and graphics

  Scenario: No product has been sold
  	Given I have not sold products
    When I go to my stores statistics page
  	Then I should see no sale message