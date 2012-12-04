Feature: Discounts

  As a user
  I want to be able to use discounts 
  
  Stakeholder: User
  Priority: High

  Background:     
  	Given I am on cart page
    And I have products to buy
    When I press use discounts button

  Scenario: Use discounts successfully
    And I fill form with code receibed from this store
    And I press submition button
    Then I should see a success message
    And should be subtracted from total the correct value discounted

  Scenario: Use discounts unsuccessfully
    And I fill form with wrong code
    And I press submition button
    Then I should see a unsuccess message