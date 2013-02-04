@order @creation @admin
Feature: Order creation

  In order to have access to the orders
  As an Admin and Root
  I want to be able to create an order

  Background:         
    # Given I am authenticated
    #And My user role is 
    #       | Admin |
    #       | Root |
    Given I am at the checkout page
    And there is a cart with at least one product

  Scenario: Create an order successfully

    I should be able to place a new order

    When I fill in all required fields for order
    # And I fill in all required fields for a master variant
    # And I submit this data
    # Then I should see a success message
    # And The new order should be stored in the database
    # And A variant marked as master should be stored in the database
    # And I should be redirected to order's index page
