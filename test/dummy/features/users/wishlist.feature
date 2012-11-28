Feature: Wishlist

  In order to save the products I want to buy
  As user
  I want to create whishlists

  Stakeholder: User
  Priority: Low

  Scenario: Create whishlist private
  	Given I am on cart page
  	And I have products to buy
  	When I press whishlist button
  	Then I should see success message

  Scenario: Create whishlist public
  	Given I am on cart page
  	And I have products to buy
  	When I select public whishlist 
  	And I press whishlist button
  	Then I should see success message

  Scenario: See public wishlist
    Given I have on public whishlists page
    When I select one whishlist
    And I press want whishlist button
    Then I should see success message
    And the whishlist is associated with my account