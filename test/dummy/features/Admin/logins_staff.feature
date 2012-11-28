Feature: Establish logins for staff

  In order to help the owner manage your store
  As a owner of the store
  I want to be able to create accounts dedicated to staff
  
  Stakeholder: Owner
  Priority: High

  Scenario: Create accounts for staff
    Given I am on back office page
    When I select add new staff member button
    And I fill de form with name and mail
    And I press submition button
    Then I should see success message