Feature: Response to User support

  In order to talk to a store owner
  As user
  I want to send a message to the owner

  Stakeholder: User
  Priority: Normal

  Scenario: Send message
    Given I am registered
    And I am on the store page
    When I click
    And I fill in the helo form
    And I click submit
    Then I should see success message

  Scenario: See response received
    Given I am registered
    And I have sent a message to a store owner
    And the store owner responded
    When I click to see my messages
    Then I should see response
