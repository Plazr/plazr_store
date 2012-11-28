Feature: Organize products

  As a store owner I should be able to organize products in categories.

  Stakeholder: Owner
  Priority: Essential

  Background:
    Given I am registered and owner
    And I am in the products edit page
    And there are products

  Scenario: Edit a product to add a new category
	  When I click to edit a product
    And And I select a category
    And I click to save
    Then the product should belong to the new category

  # Scenario: Automatically categorize products
  #   #TODO

  # Scenario: See products by category
	#   When I select the category
  #   Then I should see the all the products associated whith these category
  #