Feature: Receive newsletter

  In order to know all the news from store
  As a user of the web store
  I want to be able to receibe periodic newsletter

  Stakeholder: User 
  Priority: High

  Scenario: Subscribe to the newsletter as a registered user
    Given I am on My Account page
    When I select receive newsletter
    And I select the type of newsletters
    And I press submit button 
    Then I should see success message
    And I should receiving on my email the newsletters selected

  Scenario: Subscribe to the newsletter as a unregistered user
    Given I am on home page
    When I select receive newsletter
    And I select the type of newsletters
    And I fill form witch mail
    And I press submit
    Then I should see a success message
    And I should receiving on my email the newsletters selected

  Scenario: Cancel Subscribe to the newsletter as a registered user
    Given I am on home page
    When I select stop receive newsletter
    And I press submit
    Then I should see a success message