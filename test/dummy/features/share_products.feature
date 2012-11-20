Feature: Sharing in a social networks
  In order to share products
  As a user registered
  I want to share in a social network

  Stakeholder: User
  Priority: High

  Background: I should be registered and authenticated
    Given I am registered user
    And there are other users registered
    And I am on product page

  Scenario: Share products
		When I press share button
		Then I should see product shared on my social network