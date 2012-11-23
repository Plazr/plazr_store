Feature: Receive newsletter

  In order to receive the newsetter
  As a user of the web store
  I want to be able to receibe periodic newsletter

  Stakeholder: User 
  Priority: High

  Scenario: Select receive newletters
    Given I am on My Account page
    When I select receive newsletter
    And I select the type of newsletters
    And I press submit button 
    Then I should receiving on my email the newsletters selected