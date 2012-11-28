Feature: Notification of replacement stock

  In order to sell more
  As a owner
  I want to be able to receive request the stock replacement
  
  Stakeholder: Owner
  Priority: High

  Background:
    Given I am owner
    And the product is exhausted
    And the user request notification 

  Scenario: Receive notification of stock replacement
    Given I am on my home page
    Then I should see message of request

  Scenario: Replacement stock
    Given I am on product page
    And the product is exhausted  
    And I increase the stock
    Then should be sent a message to user