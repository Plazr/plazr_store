Feature: Feedback on Store

  In order to classify a purchase
  As a user
  I want to be able add feedback
  
  Stakeholder: User
  Priority: Medium

  Scenario: Add feedback successfully
  	Given I am on home page
    And I have buy products on this store
    When I press classify button
    And I fill form with rating
    And I fill form with comment
    Then I should see success message
    And I should see this message on home page