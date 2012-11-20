Feature: Manage Products
  In order to edit all product features
  As a registered owner of a store
  I want to manage my products
  
  Stakeholder: Owner of an online store
  Priority: Essential 

  Background: I should be registered and authenticated
    Given I am the registered owner of a store
    And there are other owners of stores
    And I am on the back office
    And I want to edit some features of a product
    And I select the product

  Scenario: Edit product successfully
    When I press the edit button
    And I edit the features of the product
    And I press submit button
    Then I should see the edited product im my store

  Scenario: Edit product unsuccessfully
    When I press the edit button
    And I edit the features of the product
    And I press submit button
    Then show the error message   
    And I should not see the edited product im my store