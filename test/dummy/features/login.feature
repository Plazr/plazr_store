Feature: Login
  In order to login in Plazr
  As an user registered
  I want to authenticated using external accounts
  
  Stakeholder: User
  Priority: Essential 

  Background: I should be registered and authenticated
    Given I am registered
    And there are other users registered
    And I am on the front page
    And I want to login in Plazr

  Scenario: Successfull login
	  When I press any button on an external account
	  Then I should be authenticated

  Scenario: Unsuccessfull login
    When I press any button on an external account
    Then show the error message   
    And I should not be authenticated
