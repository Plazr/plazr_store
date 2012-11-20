Feature: Resale products
  In order to sell products from other stores
  As a registered owner of a store
  I want to resale products in my store

  Stakeholder: Owner of an online store
  Priority: Essential 

  Background: I should be registered and authenticated
    Given I am the registered owner of a store
    And there are other owners of stores
    And I am on the other store

  Scenario: Resale products successfully
	When I select the product of other store
	And that product is available for resale 
    And I press resale button
    Then I should see that product in my store

  Scenario: Resale products unsuccessfully
	When I select the product of other store
	And that product is not available for resale
    And I press resale button
    Then show the error message
    And I should not see that product in my store