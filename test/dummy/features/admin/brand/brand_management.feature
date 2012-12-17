@brand @management @admin
Feature: Brand management

  In order to have all brand's information correct
  As an Admin and Root
  I want to be able to edit and delete an existing brand

  Background:     
    # Given I am authenticated
    # And My user role is 
    #       | Admin |
    #       | Root  |
    Given there is at least one brand


  Scenario: Edit successfully a brand

    I should be able to edit an existing brand

    Given I am at a brand's edit page
    When I edit the brand's name
    And I submit the changes
    Then I should see a success message
    And The brand data should be stored in the database
    And I should be redirected to that brand's edit page

  Scenario: Edit a brand with a required field not filled in

    I should be notified if I try to edit a brand
    with a required field not filled in

    Given I am at a brand's edit page
    When I clean the name of the brand
    And I submit the changes
    Then I should see an error message
    And I should stay at that brand's edit page

  Scenario: Delete successfully an brand

    I should be able to delete an existing brand

    Given I am at the brand's index page
    When I click the delete button
    And I confirm this decision
    Then The deleted brand shouldn't be listed
    And I should be redirected to brand's index page
