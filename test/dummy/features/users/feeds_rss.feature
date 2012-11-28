Feature: Viewer signs up for the feed RSS

  In order to receive the feed RSS
  As a user of the store
  I want to be able to sign up for the feed RSS 
  
  Stakeholder: User
  Priority: High

  Scenario: Fill out form as registered user
    Given I am on home page of store
    And I am registered user
    When I press Feed RSS button
    Then I should see success message

  Scenario: Fill out form as unregistered user
    Given I am on home page of store
    And I am unregistered user
    When I press Feed RSS button
    And I fill the email
    Then I should see success message