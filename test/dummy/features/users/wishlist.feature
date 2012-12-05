Feature: Wishlist

  In order to save the products I want to buy later
  As user
  I want to create whishlists

  Stakeholder: User
  Priority: Normal

  Scenario: Create a whishlist
    Given I am registered
  	And I am on a product page
  	When I click to add to the whishlist
  	Then I should see success message
    And the product should be in my whishlist

  Scenario: View my wishlist
    Given I am registered
    And I have products in my whishlist
    When I go to my whishlist page
    Then I should see the products