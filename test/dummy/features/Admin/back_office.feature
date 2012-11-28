Feature: Back Office
  In order to make changes in stores
  As a registered owner of a store
  I want to use a back office at each store

  Stakeholder: Owner of an online store
  Priority: Essential    

  Background: I should be registered and authenticated
    Given I am the registered owner of a store
    And there are other owners of stores
    And I am on the central page

  Scenario: Change definitions store
    When I press change store button
    And open back office store
    And I make changes on back office
    And I submit the changes
    Then I should be redirect to home page of store
    And I should see the changes in store