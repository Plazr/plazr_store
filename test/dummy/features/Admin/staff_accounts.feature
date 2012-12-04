Feature: Establish logins for staff

  In order to give backoffice acess to other users
  As a store owner
  I should be able to create staff accounts

  Stakeholder: Owner
  Priority: High

  Scenario: Create accounts for staff
    Given I am on the admin page
    When I click to add staff
    And I fill in staff form
    And I click submit
    Then I should see success message