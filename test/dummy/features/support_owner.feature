Feature: Response to user support
  
  In order to help a user
  As owner
  I want to respond to a notification

  Scenario: Response to a notification
    Given I am on my home page
    And one user send notification
    When I press read notifcation button
    And I should see notification
    And I fill in form with help description 
    And I select the response status
    Then I should see success message