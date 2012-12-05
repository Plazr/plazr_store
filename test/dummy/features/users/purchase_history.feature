Feature: Purchase history

  In order to know what I bought
  As a registered user
  I want to see the history of all my purchases

  Stakeholder: User
  Priority: Essential

  Scenario: See purchase history
	  Given I am on the home page
    And I have bought products
    When I click to see my purchase history
	  Then I should see all products I have bought