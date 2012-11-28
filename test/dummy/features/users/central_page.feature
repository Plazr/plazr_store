Feature: Central Page
  In order to group all stores and show all highlighted products of Plazr
  As an user (registered or not registered)
  I want to see central page
  
  Stakeholder: User
  Priority: Essential 

  Scenario: See Central Page
    Given I am on the Central Page
    Then I should see all stores grouped together
    And all featured products 