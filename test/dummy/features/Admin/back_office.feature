Feature: Back Office
  In order to make changes in stores
  As a registered owner
  I want to use one back office to change each store

  Stakeholder: Owner
  Priority: Essential    

  Scenario: Change definitions store
    Given I am on the central page
    When I press change store button
    And open back office store
    And I make changes on back office
    And I submit the changes
    Then I should be redirect to home page of store
    And I should see the changes in store