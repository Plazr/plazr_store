@brand @creation @admin
Feature: Brand creation

  In order to have access to the brands
  As an Admin and Root
  I want to be able to create a brand

  Background:         
    # Given I am authenticated
    #And My user role is 
    #       | Admin |
    #       | Root |
    Given I am at the brand creation page

  Scenario: Create a brand successfully

    I should be able to create a new brand

    When I fill in all fields for brand
    And I submit this data
    Then I should see a success message
    And The new brand should be stored in the database
    And I should be redirected to brand's index page


  Scenario: Create brand with required field not filled in

    I should be notified if I try to create a new brand
    without filling in all the required fields

    When I leave the brand's name blank
    And I submit this data
    Then I should see an error message
    And I should stay at the brand's creation page
