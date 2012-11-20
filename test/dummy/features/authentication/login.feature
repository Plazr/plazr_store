Feature: Login
  As a registered user I should be able to login with exernal services.
  My accounts should merge if I do it with different services.
  I should also be able to login with email and password.
  If I'm not registered I should be notified.

  Stakeholder: User
  Priority: Essential

  Scenario Outline: Successfully login with external accounts
    Given I am on the front page
    And I am registered with "<provider>"
	  When I click to login with "<provider>"
	  Then I should see a success login message
    Examples:
      | provider |
      | facebook |
      | twitter  |

  Scenario: Successfully login with email
    Given I am on the front page
    And I am registered with email and password
    When I click to login with email
    Then I should see a success login message

  Scenario: Login with wrong email/password combination
    Given I am on the front page
    And I am registered with email and password
    When I click to login with email
    And I fill in the email
    And I fill in a wrong password
    Then I should see a wrong password message