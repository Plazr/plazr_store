Feature: Share products
  I want share products with friends

  Stakeholder: User
  Priority: Medium

  Scenario: Shared products with friends
   Given I should be a user
   And I am in product page
   When I press a share button
   And I insert a friend mail
   Then I should see a sucess message

  Scenario: Shared whishlist witch friends
   Given I should be a user
   And I am on my home page
   And I have at least one whishlist
   When I select one whishlist 
   And I press a share button
   And I insert a friend mail
   Then I should see a sucess message