Feature: Resale products

  In order to sell products from other stores
  As a store owner
  I want to resale with one click

  Stakeholder: Owner
  Priority: Essential

  Background: I should be registered and there should be other store owners
    Given I am registered
    And I am a store owner
    And there are other store owners with products
    And I am in other store

  Scenario: Resale products successfully
    When I click
    And I press resale button
    Then I should see that product in my store

  Scenario: Resale products unsuccessfully
    When I select the product of other store
    And that product is not available for resale
    And I press resale button
    Then show the error message
    And I should not see that product in my store