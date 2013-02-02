@variant @creation @admin
Feature: Variant creation

  In order to have access to the variants
  As an Admin and Root
  I want to be able to create a variant

  Background:         
    # Given I am authenticated
    #And My user role is 
    #       | Admin |
    #       | Root |
    Given I am at the variant creation page

  Scenario: Create a variant

    I should be able to create a new variant and select the variant_categories and
    the variant_property_values

    When I fill in all required fields for a variant
    And I fill in the values of the variant_properties
    And I choose the variant_categories
    And I submit that data
    Then I should see a success message
    And The new variant should be stored in the database
    And I should be redirected to variant's show page
