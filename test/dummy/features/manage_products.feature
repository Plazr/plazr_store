Feature: Manage Products

  In order to edit all product features
  As a registered owner of a store
  I want to manage my products

  Stakeholder: Store owner
  Priority: Essential

  Background:
    Given I am owner of a store
    And I am on the back office


  Scenario: Edit product successfully
    Given I have products
    When I select the product
    And I press the edit button
    And I edit the features of the product
    And I press submit button
    Then I should see a sucess message

  Scenario: Edit product unsuccessfully
    When I select the product
    And I press the edit button
    And I edit the features of the product
    And I press submit button
    Then show the error message
    And I should not see the edited product