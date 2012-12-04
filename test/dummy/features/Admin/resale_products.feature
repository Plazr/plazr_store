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

  Scenario: Successfully resale product
    When I click on a product
    And I click the resale button
    Then I should see a success message
    And I should have the product