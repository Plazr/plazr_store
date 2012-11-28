Feature: Response to User support 
  
  In order to ask for help about store
  As user
  I want to send a notification to the owner

  Stakeholder: User
  Priority: 

  Scenario: Send notification
    Given I am on home page
    When I press help button
    And I fill the form with description
    And I press submition button
    Then I should see success message
    And the notification is marked unresolved
  
  Scenario: See response received
    Given I am on my home page
    And I send notification to owner
    And I have unread messages
    When I press read message button
    Then I should see response
    And I should see the response status (solved or be solved)