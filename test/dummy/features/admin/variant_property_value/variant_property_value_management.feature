@variant_property_value @management @admin
Feature: VariantPropertyValue management

  In order to have access to the variant_propertie_values
  As an Admin and Root
  I want to be able to manage the variant_propertie_values

  Background:         
    # Given I am authenticated
    #And My user role is 
    #       | Admin |
    #       | Root |
    Given I am at the variant_property_values index page

  Scenario: Create a variant_property_value

    I should be able to create a new variant_property_value

    When I fill in all required fields for a variant_property_value
    And I submit this data
    Then I should see a success message
    And The new variant_property_value should be stored in the database
    And I should be redirected to variant_property_value's index page

  Scenario: Edit a variant_property_value

    I should be able to edit an existing variant_property_value

    When I click to edit an existing variant_property_value
    And I change the value of a field
    And I submit this data
    Then I should see a success message
    And The existing variant_property_value should be updated in the database
    And I should be redirected to variant_property_value's index page

  Scenario: Delete a variant_property_value

    I should be able to delete an existing variant_property_value

    When I click to destory an existing variant_property_value
    And I confirm this decision
    Then The variant_property_value shouldn't be listed
    And I should be redirected to variant_property_value's index page
