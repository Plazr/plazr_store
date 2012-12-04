Feature: Organize products

  In order to manage my store
  As a store owner
  I should be able to organize products in categories

  Stakeholder: Owner
  Priority: Essential

  Background:
    Given I am registered
    And I am a store owner
    And I have products
    And I am on the products edit page

  Scenario: Edit a product to add a new category
	  When I click to edit a product
    And And I select a category
    And I click to save
    Then the product should belong to the new category