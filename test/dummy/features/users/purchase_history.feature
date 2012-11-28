Feature: Purchase history
  In order to see puchase history
  As an user registered
  I want to see history of all my purchases order by date

  Stakeholder: User
  Priority: Essential

  Scenario: See purchase history
	  Given I am on the front page
	  And I want to see the my history of purchases
	  When I press the history of purchases button
	  Then I should see the history of all my purchase
	  And order by date