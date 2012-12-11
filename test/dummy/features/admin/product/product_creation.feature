@product @creation @admin
Feature: Product creation

  In order to have access to the products
  As an Admin and Root
  I want to be able to create a product

  Background:         
    # Given I am authenticated
    #And My user role is 
    #       | Admin |
    #       | Root |
    Given I am at the product creation page

  Scenario: Create a product followed by the creation of a master variant

    I should be able to create a new product
    and in the background a master variant of that product should be created

    When I fill in all required fields for product
    And I fill in all required fields for a master variant
    And I submit that data
    Then I should see a success message
    And The new product should be stored in the database
    And A variant marked as master should be stored in the database
    And I should be redirected to product's index page
